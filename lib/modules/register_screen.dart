// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/home_layout.dart';
import 'package:salla_app/modules/login_screen.dart';
import 'package:salla_app/shared/cubit/register_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/register_cubit/states.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  navigateAndFinish(widget: HomeLayout(), context: context);
                  CacheHelper.saveData(
                      key: 'status', value: state.loginModel.status);
                });
              } else {
                showToast(
                  ms: '${state.loginModel.message}',
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                  ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Register now to browse our hot offers'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                        ),
                        SizedBox(height: 20.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: nameController,
                          textInputType: TextInputType.name,
                          labelText: 'User name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 16.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: 16.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Enter Password',
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: RegisterCubit.get(context).iconData,
                          onPressed: () {
                            RegisterCubit.get(context).changeObscured();
                          },
                        ),
                        SizedBox(height: 16.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          labelText: 'Phone number',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone number must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(height: 20.0),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            height: 50.0,
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).registerData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    image: '',
                                  );
                                }
                              },
                              child: Text(
                                'register'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              color: kDefualtColor,
                            ),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do You have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(
                                    widget: LoginScreen(), context: context);
                              },
                              child: Text(
                                'Login now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 100.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
