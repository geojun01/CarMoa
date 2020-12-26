import 'package:carmoa/data/car_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  // Provider 에서 데이터를 공유하려면 carData 에 바로 접근하면 안된다.
  final carData = List<CarModel>();
  int _cycle;

  getDateLast() => carData.last.dateTime;
  getNameLast() => carData.last.nameCode;
  getExchangeLast() => carData.last.exchange;
  getPeriod() => carData.last.period;
  getIdLast() => carData.last.id;
  getPrice() => carData.last.price;

  getIndex() => carData.length;

  getCycle() => _cycle;

  void listAdd(List<CarModel> item) async {
    await Future.microtask(() {
      // 프로그램 첫 시작시 SQLite 데이터 로드 후 한번만 실행 되게 한다.
      if (carData.length <= 0 && carData.isEmpty) {
        try {
          // SQLite 에서 데이터룰 읽어 오면 시간차로 데이터가 들어오기 때문에
          // Provider - item 에 데이터가 들어올 때만 실행한다.
          // 현재 조건문이 없으면 첫 로딩시 데이터가 없어 예외처리 된다.
          if (item != null && item.length > 0) {
            item.forEach((element) {
              itemAdd(element);
            });
          }
        } catch (e) {
          throw FormatException('예외처리: ${e.toString()}');
        }
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
    if (getIndex() > 0) {
      carData.clear();
    }
    notifyListeners();
  }

  void setCycleCheck(int cycle) {
    _cycle = cycle;
    notifyListeners();
  }
}