// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/favorites_get_model.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';

import '../shared/components/components.dart';
import '../shared/cubit/app_cubit/cubit.dart';
import '../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).favGetModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                AppCubit.get(context).favGetModel!.data.data[index], context),
            separatorBuilder: (context, index) => Divider(),
            itemCount: AppCubit.get(context).favGetModel!.data.data.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildFavItem(FavDataItemsModel model, context) => Container(
        height: 130,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  height: 130.0,
                  width: 130.0,
                  image: NetworkImage(
                    model.product.image,
                  ),
                ),
                if (model.product.discount != 0)
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
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.product.price.round()}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.0,
                              color: kDefualtColor,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10.0),
                      if (model.product.discount != 0)
                        Text(
                          '${model.product.oldPrice.round()}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                      SizedBox(width: 20.0),
                      if (model.product.discount != 0)
                        Text(
                          '${calculateDiscount(model.product).round()}%',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 13.0, color: kDefualtColor),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 16.0,
                        backgroundColor:
                            AppCubit.get(context).favorites[model.product.id]!
                                ? kDefualtColor
                                : Colors.grey[400],
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppCubit.get(context)
                                .changeFavModel(model.product.id);
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
            )
          ],
        ),
      );
}
