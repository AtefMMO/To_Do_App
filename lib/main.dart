import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/home_screen/home_screen.dart';
import 'package:todoapp/login_screen/login.dart';
import 'package:todoapp/register_screen/register.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/providers/auth_provider.dart';
import 'package:todoapp/providers/list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (BuildContext context) => AppConfigProvider()),
    ChangeNotifierProvider(create: (BuildContext context) => ListProvider()),
    ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      initialRoute: LoginScreen.RouteName,
      routes: {
        HomeScreen.RouteName: (context) => HomeScreen(),
        LoginScreen.RouteName: (context) => LoginScreen(),
        RegisterScreen.RouteName: (context) => RegisterScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.DarkTheme,
      themeMode: provider.appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
