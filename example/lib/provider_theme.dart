import 'package:example/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _currentTheme;

  ThemeProvider() {
    _currentTheme = CustomTheme.purple;
  }

  set currentTheme(ThemeData themeData) {
    _currentTheme = themeData;
    notifyListeners();
  }

  ThemeData get currentTheme => _currentTheme;
}
