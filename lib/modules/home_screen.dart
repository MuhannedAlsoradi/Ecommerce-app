// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/models/home_model.dart';
import 'package:salla_app/shared/components/components.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';
import 'package:salla_app/shared/cubit/theme_cubit/cubit.dart';
import 'package:salla_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  var carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is FavoritesDataSuccessState) {
          if (!state.model.status) {
            showToast(ms: state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel != null &&
              AppCubit.get(context).categoryModel != null,
          builder: (context) =>
              buildHomePage(AppCubit.get(context).homeModel, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildHomePage(HomeModel? model, context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  items: model?.data.banners
                      .map(
                        (e) => Image(
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          image: NetworkImage(e.image),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      AppCubit.get(context).changeCarouselIndex(index);
                    },
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlay: true,
                    reverse: false,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0,
                    autoPlayCurve: Curves.linearToEaseOut,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedSmoothIndicator(
                    count: model!.data.banners.length,
                    activeIndex: AppCubit.get(context).activeIndex,
                    effect: ExpandingDotsEffect(
                        expansionFactor: 2,
                        spacing: 7,
                        dotColor: Colors.grey.withOpacity(0.5),
                        activeDotColor: kDefualtColor),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                  ),
                  Container(
                    height: 130.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCatItem(
                        AppCubit.get(context).categoryModel!.data!.data![index],
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.0),
                      itemCount: AppCubit.get(context)
                          .categoryModel!
                          .data!
                          .data!
                          .length,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.64,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridItem(
                    AppCubit.get(context).homeModel!.data.products[index],
                    index,
                    context,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCatItem(DataModel data) {
    return Container(
      height: 100.0,
      width: 100.0,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            image: NetworkImage(
              data.image,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: double.infinity,
            child: Text(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(Products model, int index, context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color:
          ThemeCubit.get(context).isDark ? HexColor('#333333') : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                width: double.infinity,
                height: 200.0,
                image: NetworkImage(
                  model.image,
                ),
              ),
              if (model.discount != 0)
                Container(
                  height: 30.0,
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  color: Colors.red,
                )
            ],
          ),
          Text(
            model.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                '${model.price.round()}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kDefualtColor,
                      fontSize: 12.0,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 10.0),
              if (model.discount != 0)
                Text(
                  '${model.oldPrice.round()}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey[400],
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(width: 20.0),
              if (model.discount != 0)
                Text(
                  '${calculateDiscount(model).round()}%',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 13.0, color: kDefualtColor),
                ),
              Spacer(),
              CircleAvatar(
                radius: 16.0,
                backgroundColor: AppCubit.get(context).favorites[model.id]!
                    ? kDefualtColor
                    : Colors.grey[400],
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppCubit.get(context).changeFavModel(model.id);
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
