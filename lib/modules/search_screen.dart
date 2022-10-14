// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/search_model.dart';
import 'package:salla_app/shared/components/components.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/search_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/search_cubit/states.dart';

import '../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is LoadingSearchState) LinearProgressIndicator(),
                SizedBox(height: 20.0),
                Form(
                  key: formKey,
                  child: defualtTextField(
                    onSubmit: (value) {
                      if (formKey.currentState!.validate()) {
                        SearchCubit.get(context).searchGetData(value: value);
                      }
                    },
                    autoFocus: true,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: searchController,
                    textInputType: TextInputType.text,
                    labelText: 'Search',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter any character to search';
                      }
                      return null;
                    },
                    prefixIcon: Icons.search,
                  ),
                ),
                SizedBox(height: 30.0),
                if (state is SuccessSearchState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildSearchItem(
                          SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data[index],
                          context),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: SearchCubit.get(context)
                          .searchModel!
                          .data!
                          .data
                          .length,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildSearchItem(Product model, context) => Container(
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
                image: NetworkImage(model.image),
              ),
            ],
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
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
                      '${model.price}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12.0,
                            color: kDefualtColor,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 10.0),
                    Spacer(),
                    CircleAvatar(
                      radius: 16.0,
                      backgroundColor:
                          AppCubit.get(context).favorites[model.id]!
                              ? kDefualtColor
                              : Colors.grey[400],
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
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
          ),
        ],
      ),
    );
