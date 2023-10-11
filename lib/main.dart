import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/home_screen/home_screen.dart';
import 'package:todoapp/providers/list_provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
    create: (context) => ListProvider(),
      child: MyApp()));
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
