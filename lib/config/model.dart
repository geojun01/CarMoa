import 'package:carmoa/data/car_data_model.dart';
import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  static List<CarModel> carData = List<CarModel>();

  int itemIndex = 0;
  String name;
  String exchange;

  void index(int index) {
    itemIndex = index - 1;
    name = carData[itemIndex - 1].nameCode;
    exchange = carData[itemIndex - 1].exchange;
    notifyListeners();
  }

  void nameValue() {
    name = carData[itemIndex - 1].nameCode;
    // name = carData[itemIndex - 1].nameCode;
    notifyListeners();
  }

  void add(CarModel item) {
    carData.add(item);
    notifyListeners();
  }

  void update(CarModel item) {
    carData.insert(item.id, item);
  }

  void remove(CarModel item) {
    carData.remove(item);
    notifyListeners();
  }

  void removeAll() {
    carData.clear();
    notifyListeners();
  }

  // Test Code
  void textData() {
    carData.length;
    notifyListeners();
  }

  String textData1(int index) {
    return carData[index].exchange;
  }
  // Test Code
}
