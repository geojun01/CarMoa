import 'dart:convert';

import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scaling_header/scaling_header.dart';

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
              centerInformationView(Icons.image, Colors.black38, "자동차 정보"),
              centerInformationView(Icons.camera, Colors.black38, "노래방"),
              centerInformationView(Icons.search, Colors.black38, "자료 검색"),
            ],
          ),
        ),
      ),
    );
  }

  // 상단 메인 로그 및 정보창
  Container topInformationView(BuildContext context) {
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Car Moa",
                    style: Styles.titleBoldFont,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '새로운 자동차 관리 프로그램',
                    style: Styles.titleMinFont,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 중앙 데이터 화면
  Container centerInformationView(
      IconData icons, Color iconColor, String text) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          icons,
                          color: iconColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          text,
                          style: Styles.mainFont,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('자료 1')
                  ],
                ),
              ),
            ),
          ),
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
