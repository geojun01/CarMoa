import 'package:flutter/foundation.dart';

class Location with ChangeNotifier {
  double _lat;
  double _lon;
  String _description;
  String _city;
  String _iconName;
  int _id;
  int _temp;

  getLat() => _lat;

  getLon() => _lon;

  getDescription() => _description;

  getCity() => _city;

  getIcon() => _iconName;

  getTemp() => _temp;

  getId() => _id;

  void setLocation(double lat, double lon) {
    _lat = lat;
    _lon = lon;
    notifyListeners();
  }

  void setWeather(int temp, String description, String city, String iconName, int id) {
    _temp = temp;
    _description = description;
    _city = city;
    _iconName = iconName;
    _id = id;
    notifyListeners();
  }
}
