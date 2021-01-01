import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';

class CreateDB {
  Future<List<CarModel>> loadData() async {
    DBHelper db = DBHelper();
    List<CarModel> aa = await db.loadData();

    return aa;
  }

  Future<void> saveData(CarModel item) async {
    DBHelper db = DBHelper();
    await db.insertData(new CarModel(
        id: DateTime.now().toString(),
        dateTime: DateTime.now().toString(),
        nameCode: item.nameCode,
        exchange: item.exchange,
        price: item.price,
        period: item.period,
        front: item.front,
        back: item.back));
  }

  Future<void> saveItem(CarModel item) async {
    DBHelper db = DBHelper();
    await db.insertData(new CarModel(
        id: DateTime.now().toString(),
        dateTime: DateTime.now().toString(),
        nameCode: item.nameCode,
        exchange: item.exchange,
        price: item.price,
        period: item.period,
        front: item.front,
        back: item.back));
  }
}