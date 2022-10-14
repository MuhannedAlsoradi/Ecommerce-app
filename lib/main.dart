// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/home_layout.dart';
import 'package:salla_app/modules/login_screen.dart';
import 'package:salla_app/modules/on_board_screen.dart';
import 'package:salla_app/shared/components/constants.dart';
import 'package:salla_app/shared/cubit/app_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/theme_cubit/cubit.dart';
import 'package:salla_app/shared/cubit/theme_cubit/states.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';
import 'package:salla_app/shared/network/remote/dio_helper.dart';
import 'package:salla_app/shared/styles/themes.dart';
import 'shared/cubit/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? onboarding = CacheHelper.getBoolData(key: 'onBoarding');
  bool? status = CacheHelper.getBoolData(key: 'status');
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  token = CacheHelper.getStringData(key: 'token');
  print(token);
  late Widget widget;
  if (onboarding!) {
    if (status!) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  DioHelper.init();
  runApp(
    MyApp(startWidget: widget, isDark: isDark),
  );
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  bool? isDark;
  MyApp({this.startWidget, this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getHomeData()
            ..getCategory()
            ..favGetDataModel()
            ..GetUserDataModel()
            ..GetUserDataModel(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()
            ..changeAppTheme(
              fromShared: isDark!,
            ),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: ligtTheme,
            darkTheme: darkTheme,
            themeMode: ThemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
