import 'package:carmoa/data/car_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  // Provider 에서 데이터를 공유하려면 carData 에 바로 접근하면 안된다.
  final carData = List<CarModel>();
  final selectData = List<CarModel>();
  int _cycle;
  int _totalPrice;


  getDateLast() => selectData.last.dateTime;
  getNameLast() => selectData.last.nameCode;
  getExchangeLast() => selectData.last.exchange;
  getPeriod() => selectData.last.period;
  getIdLast() => selectData.last.id;
  getPrice() => selectData.last.price;
  getFront() => selectData.last.front;
  getBack() => selectData.last.back;

  getIndex() => selectData.length;
  getAllIndex() => carData.length;

  getCycle() => _cycle;

  getTotalPrice() => _totalPrice;

  setClear() => selectData.clear();

  getData(int _i) => selectData[_i];


  void selectItemCheck() {
    selectData.length;
    notifyListeners();
  }

  void selectItemAdd(CarModel item) {
    selectData.add(item);
    // notifyListeners(); 추가하면 에러
  }

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

  void itemDelete(CarModel item) {
    carData.remove(item);
    selectData.remove(item);
    notifyListeners();
  }

  void listDelete(CarModel item) {
    carData.remove(item);
    selectData.remove(item);
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

  void setTotalPrice(int price) {
    _totalPrice = price;
  }
}