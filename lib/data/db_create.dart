import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';

class CreateDB {
  Future<List<CarModel>> loadData() async {
    DBHelper db = DBHelper();
    List<CarModel> aa = await db.loadData();

    return aa;
  }

  Future<void> saveData(int index) async {
    DBHelper db = DBHelper();
    await db.insertData(new CarModel(
        id: index.toString(),
        dateTime: DateTime.now().toString(),
        nameCode: '자료 ${index.toString()}',
        exchange: index,
        price: 40000 + index,
        period: '입력',
        front: '앞',
        back: '뒤'));
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