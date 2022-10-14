// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/models/category_model.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).categoryModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildcatoItem(
              AppCubit.get(context).categoryModel!.data!.data![index],
              context,
            ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: AppCubit.get(context).categoryModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Padding buildcatoItem(DataModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Image.network(
              model.image,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
