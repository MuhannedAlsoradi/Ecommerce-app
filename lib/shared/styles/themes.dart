// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salla_app/shared/styles/colors.dart';

ThemeData ligtTheme = ThemeData(
  fontFamily: 'Cairo',
  iconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: kDefualtColor,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Cairo',
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: kDefualtColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 24.0,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Cairo',
  iconTheme: const IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: kDefualtColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    backgroundColor: HexColor('#333333'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Cairo',
    ),
  ),
  scaffoldBackgroundColor: HexColor('#333333'),
  primarySwatch: kDefualtColor,
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
      size: 24.0,
    ),
    backgroundColor: HexColor('#333333'),
    elevation: 0.0,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#333333'),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
);
