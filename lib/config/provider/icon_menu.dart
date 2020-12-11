import 'package:flutter/foundation.dart';

class IconMenu with ChangeNotifier {
  int _index = 1;

  double _menuA = 0.5;
  double _menuB = 0.25;
  double _menuC = 0.25;

  getMenuA() => _menuA;
  getMenuB() => _menuB;
  getMenuC() => _menuC;

  getMenuIndex() => _index;

  void menuSelect(int index) {
    _index = index;

    switch(index) {
      case 1:
        _menuA = 0.5;
        _menuB = 0.25;
        _menuC = 0.25;
        break;
      case 2:
        _menuA = 0.25;
        _menuB = 0.5;
        _menuC = 0.25;
        break;
      case 3:
        _menuA = 0.25;
        _menuB = 0.25;
        _menuC = 0.5;
        break;
    }
    notifyListeners();
  }
}