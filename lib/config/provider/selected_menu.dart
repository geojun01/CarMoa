import 'package:flutter/foundation.dart';

class SelectMenu with ChangeNotifier{
  int _select = 0;

  int getSelect() => _select;

  void setSelect(int select) {
    _select = select;
    notifyListeners();
  }
}