import 'package:flutter/material.dart';
import 'package:flutter_base_template/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider(BuildContext context) {
    // Initialize theme based on system preference or default to light mode
    _themeData = lightMode(context);
  }

  // Getter for current theme data
  ThemeData get themeData => _themeData;

  bool get isDarkModeOn => _themeData.brightness == Brightness.dark;

  void toggleTheme(BuildContext context) {
    if (isDarkModeOn) {
      _themeData = lightMode(context);
    } else {
      _themeData = darkMode(context);
    }
    notifyListeners();
  }
}
