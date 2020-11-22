import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:carmoa/data/car_data_model.dart';

final String tableName = 'car_moa';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'car_moa.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE car_moa(id STRING PRIMARY KEY, dateTime TEXT, nameCode TEXT, exchange TEXT, price INTEGER, front TEXT, back TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertData(CarModel model) async {
    final db = await database;
    await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
        front: maps[i]['front'],
        back: maps[i]['back'],
      );
    });
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

  Future<void> deleteMemo(int id) async {
    final db = await database;

    await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete('DELETE FORM $tableName');
  }
}
