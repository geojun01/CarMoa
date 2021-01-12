import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';

class CreateDB {
  Future<List<CarModel>> loadData() async {
    DBHelper db = DBHelper();
    // List<CarModel> aa = await db.loadData();
    List<CarModel> aa = await db.getAll();

    return aa;
  }

  Future<void> saveData(CarModel item) async {
    DBHelper db = DBHelper();
    await db.insertData(new CarModel(
        id: item.id,
        dateTime: item.dateTime,
        nameCode: item.nameCode,
        exchange: item.exchange,
        price: item.price,
        period: item.period,
        front: item.front,
        back: item.back));
  }

  Future<void> deleteData(CarModel item) async {
    DBHelper db = DBHelper();
    await db.deleteData(item.id);
  }

}