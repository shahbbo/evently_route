import 'package:flutter/material.dart';
import '../../core/network/local/cache_helper.dart';


class AppLanguageProvider extends ChangeNotifier {

  String appLanguage = 'en';

  void loadLanguageFromCache() {
    String? cachedLanguage = CacheHelper.getData(key: 'Language');
    if (cachedLanguage != null) {
      appLanguage = cachedLanguage;
    } else {
      CacheHelper.saveData(key: 'Language', value: 'en');
    }
  }

  void changeAppLanguage(String newLanguage) {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    CacheHelper.saveData(key: 'Language', value: newLanguage);
    notifyListeners();
  }
}
