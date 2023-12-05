import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  changeTheme(ThemeMode newTheme) {
    if (appTheme != newTheme) {
      appTheme = newTheme;
    }

    notifyListeners();
  }
}
