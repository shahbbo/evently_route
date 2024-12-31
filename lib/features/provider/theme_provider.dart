import 'package:event_planning_app/core/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {

  bool isDarkTheme = false;


  void loadThemeFromCache() {
    bool? cachedTheme = CacheHelper.getData(key: 'theme');
    if (cachedTheme != null) {
      isDarkTheme = cachedTheme;
    } else {
      changeAppTheme(false);
    }
  }

  void changeAppTheme(bool isDark) {
    if (isDarkTheme == isDark) return;
    isDarkTheme = isDark;
    CacheHelper.saveData(key: 'theme', value: isDark);
    notifyListeners();
  }

  ThemeMode get appTheme {
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
}
