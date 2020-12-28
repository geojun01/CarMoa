import 'package:flutter/foundation.dart';

class Cycle with ChangeNotifier {
  int _engValue;
  int _airValue;
  int _tireValue;
  int _breakValue;
  int _breakOilValue;

  getEng() => _engValue;
  getAir() => _airValue;
  getTire() => _tireValue;
  getBreak() => _breakValue;
  getBreakOil() => _breakOilValue;

  void setEng(int engValue) {
    _engValue = engValue;
    notifyListeners();
  }

  void setAir(int airValue) {
    _airValue = airValue;
    notifyListeners();
  }

  void setTire(int tireValue) {
    _tireValue = tireValue;
    notifyListeners();
  }

  void setBreak(int breakValue) {
    _breakValue = breakValue;
    notifyListeners();
  }

  void setBreakOil(int breakOilValue) {
    _breakOilValue = breakOilValue;
    notifyListeners();
  }
}