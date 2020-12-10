import 'package:carmoa/data/car_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  final carData = List<CarModel>();
  int _index = 0;

  getId() => carData[carData.length - 1].id;

  getName() => carData[carData.length - 1].nameCode;

  getCode() => carData[carData.length - 1].exchange;

  // int get getIndex => carData.length;
  getIndex() => carData.length;


  void listAdd(List<CarModel> item) async {
    await Future.microtask(() {
      if (carData.length <= 0 && carData.isEmpty) {
        try {
          carData.addAll(item);
        } catch (e){
          print('${e.toString()}');
        }
        _index = carData.length;
        print('Data read ...');
      } else {
        print('pass ...');
      }
    });

    // if (carData.length <= 0 && carData.isEmpty) {
    //   try {
    //     carData.addAll(item);
    //   } catch (e){
    //     print('${e.toString()}');
    //   }
    //   _index = carData.length;
    // }
  }

  void itemAdd(CarModel item) {
    carData.add(item);
    _index = carData.length;
    notifyListeners();
  }

  void listClear() {
    print ('내부 : $carData.length');
    if (getIndex() > 0) {
      carData.clear();
    }
    notifyListeners();
  }
}

var model = Model();
