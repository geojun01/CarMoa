import 'package:carmoa/data/car_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'car_moa';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'car_moa.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY, dateTime TEXT, nameCode TEXT, exchange INTEGER, price INTEGER, period TEXT, front TEXT, back TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<CarModel> insertData(CarModel model) async {
    final db = await database;
    await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return model;
  }

  Future<List<CarModel>> loadData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('car_moa');

    return List.generate(maps.length, (i) {
      return CarModel(
        id: maps[i]['id'],
        dateTime: maps[i]['dateTime'],
        nameCode: maps[i]['nameCode'],
        exchange: maps[i]['exchange'],
        price: maps[i]['price'],
        period: maps[i]['period'],
        front: maps[i]['front'],
        back: maps[i]['back'],
      );
    });
  }

  Future<List<CarModel>> getAll() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $tableName');
    List<CarModel> list = res.isNotEmpty
        ? res.map((e) => CarModel(
                  id: e['id'],
                  dateTime: e['dateTime'],
                  nameCode: e['nameCode'],
                  exchange: e['exchange'],
                  price: e['price'],
                  period: e['period'],
                  front: e['front'],
                  back: e['back'],
                )).toList() : [];
    return list;
  }

  Future<void> updateData(CarModel model) async {
    final db = await database;

    await db.update(
      tableName,
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  Future<void> deleteData(String id) async {
    final db = await database;

    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    db.rawDelete('DELETE FORM $tableName');
  }
}
