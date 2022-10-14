// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/home_layout.dart';
import 'package:salla_app/modules/register_screen.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';
import 'package:salla_app/shared/styles/colors.dart';
import '../shared/components/components.dart';
import '../shared/cubit/login_cubit/cubit.dart';
import '../shared/cubit/login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                if (value) {
                  print(value);
                  navigateAndFinish(context: context, widget: HomeLayout());
                }
              });

              CacheHelper.saveData(
                key: 'status',
                value: state.loginModel.status,
              ).then((value) {
                if (value) {
                  print(value);
                  navigateAndFinish(context: context, widget: HomeLayout());
                }
              });
            } else {
              showToast(
                ms: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'Login'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Login to browse our hot offers'.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                        ),
                        SizedBox(height: 20.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Enter Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: 16.0),
                        defualtTextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          isPassword: LoginCubit.get(context).isPassword,
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
                          suffixIcon: LoginCubit.get(context).iconData,
                          onPressed: () {
                            LoginCubit.get(context).changeObscured();
                          },
                          onSubmit: (p0) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).loginData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).loginData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'login'.toUpperCase(),
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
                              'Don\'t have an account?',
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
                                    widget: RegisterScreen(), context: context);
                              },
                              child: Text(
                                'Register now',
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
          );
        },
      ),
    );
  }
}
