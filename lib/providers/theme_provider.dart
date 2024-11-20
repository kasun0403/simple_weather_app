import 'package:flutter/material.dart';
import 'package:simple_weather_app/services/theme_persistance.dart';
import 'package:simple_weather_app/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemesData().lightMode;
  final ThemePersistance _themePersistance = ThemePersistance();
  //constructor
  ThemeProvider() {
    _loadTheme();
  }
//getter
  ThemeData get getThemeData => _themeData;

//setter
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    bool isDark = await _themePersistance.loadTheme();
    setThemeData = isDark ? ThemesData().darkMode : ThemesData().lightMode;
  }

  //toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData = isDark ? ThemesData().darkMode : ThemesData().lightMode;
    await _themePersistance.storeTheme(isDark);
  }
}
