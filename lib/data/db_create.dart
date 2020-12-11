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
        id: index,
        dateTime: DateTime.now().toString(),
        nameCode: '자료 ${index.toString()}',
        exchange: '교환 ${index.toString()}',
        price: 40000 + index,
        front: '앞',
        back: '뒤'));
  }
}