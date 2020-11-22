import 'dart:convert';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              topInformationView(context),
            ],
          ),
        ),
      ),
    );
  }

  // 상단 정보 창
  Container topInformationView(BuildContext context) {
    return Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('클릭');
                    },
                    child: Image.asset(
                      'assets/images/sorento.png',
                      height: 100,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('마이카 정보',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('차종 : 기아 쏘렌토', style: TextStyle(fontSize: 14)),
                      Text('연식 : 2018년 9월', style: TextStyle(fontSize: 14))
                    ],
                  )
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
