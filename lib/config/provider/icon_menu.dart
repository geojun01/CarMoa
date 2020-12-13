import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconMenu with ChangeNotifier {
  int _index = 1;

  int _menuA = 2;
  int _menuB = 1;
  int _menuC = 1;
  int _menuD = 1;

  getMenuA() => _menuA;
  getMenuB() => _menuB;
  getMenuC() => _menuC;
  getMenuD() => _menuD;

  getMenuIndex() => _index;

  void menuSelect(int index) {
    _index = index;

    switch(index) {
      case 1:
        _menuA = 2;
        _menuB = 1;
        _menuC = 1;
        _menuD = 1;
        break;
      case 2:
        _menuA = 1;
        _menuB = 2;
        _menuC = 1;
        _menuD = 1;
        break;
      case 3:
        _menuA = 1;
        _menuB = 1;
        _menuC = 2;
        _menuD = 1;
        break;
      case 4:
        _menuA = 1;
        _menuB = 1;
        _menuC = 1;
        _menuD = 2;
        break;
    }
    notifyListeners();
  }
}