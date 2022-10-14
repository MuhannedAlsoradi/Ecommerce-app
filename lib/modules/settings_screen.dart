// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/modules/login_screen.dart';
import 'package:salla_app/shared/components/components.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/app_cubit/states.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';
import 'package:salla_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = AppCubit.get(context).model!;
          nameController.text = model.data!.name;
          emailController.text = model.data!.email;
          phoneController.text = model.data!.phone;
          return ConditionalBuilder(
            condition: state is! UserGetDataLoadingState,
            builder: (context) => Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        if (state is UserUpdateDataLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(height: 10.0),
                        CircleAvatar(
                          radius: 82.5,
                          child: CircleAvatar(
                            radius: 81.0,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: NetworkImage(
                                'https://scontent.fgza2-1.fna.fbcdn.net/v/t39.30808-6/278097263_1915463335472774_1520428944919852700_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=LWfUSVkMWqcAX_Qeh8Z&_nc_ht=scontent.fgza2-1.fna&oh=00_AT-3-xG5OBCFklfrtGR8ViWeQ5XUW7TDvIRFKmQHOSeffQ&oe=633540B8'),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: nameController,
                          textInputType: TextInputType.name,
                          labelText: 'Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must nut be empty ';
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 15.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must nut be empty ';
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 15.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'Phone',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must nut be empty ';
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kDefualtColor,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    AppCubit.get(context).updateUserDataModel(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        image: '',
                                        name: nameController.text);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'update'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(
                                        Icons.update,
                                        size: 18.0,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kDefualtColor,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    CacheHelper.removeData(key: 'token');
                                    CacheHelper.removeData(key: 'status');
                                    navigateAndFinish(
                                        widget: LoginScreen(),
                                        context: context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Log out'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(
                                        Icons.logout,
                                        size: 18.0,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
