import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  void changeLocale(String localeCode) {
    _currentLocale = Locale(localeCode);
    notifyListeners();
  }
}
