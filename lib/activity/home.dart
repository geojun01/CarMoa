import 'dart:convert';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final mContext = context;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topInformationView(context),
              _centerInformationView(),
            ],
          ),
        ),
      ),
    );
  }

  // 상단 메인 로그 및 정보창
  Container _topInformationView(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 190,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-image.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: sHeight * 0.04,
            left: sWidth * 0.1,
            child: Container(
              width: sWidth * 0.8,
              height: sHeight * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                    bottomLeft: Radius.circular(36)),
                border: Border.all(
                    color: Color.fromRGBO(102, 204, 204, 0.4), width: 6),
                // boxShadow: [
                //   new BoxShadow(
                //     color: Colors.white10,
                //   )
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Car Moa",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '새로운 자동차 관리 프로그램',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _centerInformationView() {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text('data')
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
