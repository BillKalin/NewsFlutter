import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _themeData;
  MaterialColor _themeColor = Colors.blue;

  ThemeData get themeData => _themeData;

  MaterialColor get themeColor => _themeColor;

  void setThemeData({ThemeData data, MaterialColor color}) {
    _themeData = data;
    _themeColor = color;
    notifyListeners();
  }
}
