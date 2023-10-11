import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  changeTheme(ThemeMode newTheme) {
    if (appTheme != newTheme) {
      appTheme = newTheme;
    }

    notifyListeners();
  }
}
