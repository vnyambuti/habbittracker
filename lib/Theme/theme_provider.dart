import 'package:flutter/material.dart';
import 'dark.dart';
import 'light.dart';

class ThemeProvider extends ChangeNotifier {
  //initialize light mode
  ThemeData _themeData = lightmode;

  //get current theme

  ThemeData get themeData => _themeData;

  //check if its darkmode

  bool get isDark => _themeData == darkmode;

  //set theme

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle theme

  void toogleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}
