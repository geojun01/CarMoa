import 'package:flutter/material.dart';

class SelectMenu with ChangeNotifier{
  // 메뉴 설정
  int _select = 0;

  int getSelect() => _select;

  void setSelect(int select) {
    _select = select;
    notifyListeners();
  }

  // 테마 설정
  ThemeData _themeData;
  String _themeName;

  getTheme() => _themeData;
  getThemeName() => _themeName;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  setThemeName(String name) {
    _themeName = name;
    notifyListeners();
  }
}