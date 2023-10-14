import 'package:test/core/constant/app_color.dart';
import 'package:flutter/material.dart';

ThemeData englishTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: AppColor.primaryColor),
    titleTextStyle: const TextStyle(
        fontSize: 30,
        color: AppColor.primaryColor,
        fontWeight: FontWeight.bold),
    backgroundColor: Colors.grey[50],
    centerTitle: true,
    elevation: 0.0,
  ),
  fontFamily: "PlayfairDisplay",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 15,
    ),
  ),
  primarySwatch: Colors.blue,
);

ThemeData arabicTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: AppColor.primaryColor),
    titleTextStyle: const TextStyle(
        fontSize: 30,
        color: AppColor.primaryColor,
        fontWeight: FontWeight.bold),
    backgroundColor: Colors.grey[50],
    centerTitle: true,
    elevation: 0.0,
  ),
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 15,
    ),
  ),
  primarySwatch: Colors.blue,
);
