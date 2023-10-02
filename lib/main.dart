import 'package:flutter/material.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.RouteName,
      routes: {
        HomeScreen.RouteName: (context) => HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      //  darkTheme: ,
      //  themeMode: ,
      debugShowCheckedModeBanner: false,
    );
  }
}
