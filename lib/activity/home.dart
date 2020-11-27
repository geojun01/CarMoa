import 'dart:convert';

import 'package:carmoa/activity/car.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
import 'package:carmoa/main_screen/drawerScreen.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          Car()
        ],
      ),
    );
  }

  // 데이터 저장
  Future<void> saveDB() async {
    DBHelper db = DBHelper();

    var bytes = utf8.encode(DateTime.now().toString());
    var digest = sha512.convert(bytes);
    String time = DateFormat("yyyy년 MM월 dd일").format(DateTime.now()).toString();
    String id = digest.toString();

    var fido = CarModel(
      id: id,
      nameCode: "Test",
      exchange: "1900",
      dateTime: time,
      price: 120,
      front: "OK",
      back: "NO",
    );
    await db.insertData(fido);

    print(await db.loadData());
  }
}
