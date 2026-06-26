import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  String locale = "en";

  void changeThemeMode(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }

  void changeLanguage(String lang){
    locale = lang;
    notifyListeners();
  }

}
