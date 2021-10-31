import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xfff5f5f5),
      buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25)),
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
          headline2: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black),
          headline3: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey),
          headline5: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          headline6: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
          bodyText1: TextStyle(fontSize: 18),
          button: TextStyle(fontSize: 16)),
    );
  }
}
