import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistance {
  //store the theme in shared pref
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isDark", isDark);
    print("theme store in pref");
  }

  //Load the saved theme
  Future<bool> loadTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("theme loaded");
    return pref.getBool("isDark") ?? false;
  }
}
