
import 'package:flutter/foundation.dart';

class Location with ChangeNotifier {
  double _lat;
  double _lon;

  getLat() => _lat;
  getLon() => _lon;

  void setLocation(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    notifyListeners();
  }
}