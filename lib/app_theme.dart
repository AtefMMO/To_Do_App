import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBlue = Color(0xff5D9CEC);
  static Color white = Color(0xffFFFFFF);
  static Color green = Color(0xff61E757);
  static Color grey = Color(0xffa6a6ab);
  static Color black = Color(0xff363636);
  static Color red = Color(0xffEC4B4B);
  static Color lightGreen = Color(0xffDFECDB);
  static Color darkBlue = Color(0xff060E1E);
  static Color lightBlack = Color(0xff3E4A59);
  static ThemeData lightTheme = ThemeData(
      primaryColor: lightBlue,
      scaffoldBackgroundColor: lightGreen,
      appBarTheme: AppBarTheme(backgroundColor: lightBlue, elevation: 0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: lightBlue,
          unselectedItemColor: grey,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: lightBlue)
  ,textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,fontSize:20,color: white
      ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,fontSize: 20,color: black
    ),
      titleSmall: TextStyle(
         fontSize: 15,color: grey
      )
  )
  );
}
