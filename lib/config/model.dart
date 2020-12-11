import 'package:carmoa/data/car_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  final carData = List<CarModel>();

  // 마지막 데이터 Get
  getNameLast() => carData.last.nameCode;
  getCodeLast() => carData.last.exchange;
  getIdLast() => carData.last.id;

  getIndex() => carData.length;

  void listAdd(List<CarModel> item) async {
    await Future.microtask(() {
      // 프로그램 첫 시작시 SQLite 데이터 로드 후 한번만 실행 되게 한다.
      if (carData.length <= 0 && carData.isEmpty) {
        try {
          // SQLite 에서 데이터룰 읽어 오면 시간차로 데이터가 들어오기 때문에
          // Provider - item 에 데이터가 들어 올때만 실행한다.
          // 현재 조건문이 없으면 첫 로딩시 데이터가 없어 예외처리 된다.
          if (item != null && item.length > 0) {
            item.forEach((element) {
              itemAdd(element);
            });
          }
        } catch (e) {
          print('예외처리: ${e.toString()}');
        }
        print('Data read ...');
      } else {
        print('pass ...');
      }
    });
  }

  void itemAdd(CarModel item) {
    carData.add(item);
    notifyListeners();
  }

  void itemDelete(int index) {
    carData.removeAt(index);
    notifyListeners();
  }

  void listClear() {
    print('내부 : $carData.length');
    if (getIndex() > 0) {
      carData.clear();
    }
    notifyListeners();
  }
}