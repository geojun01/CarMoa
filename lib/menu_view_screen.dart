import 'package:carmoa/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:carmoa/activity/car.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CarMoaMain extends StatefulWidget {
  @override
  _CarMoaMainState createState() => _CarMoaMainState();
}

class _CarMoaMainState extends State<CarMoaMain> {
  int _selectedIndex = 0;

  // 하단 바 메뉴 list
  List _selectedMenu = [
    Home(),
    Car(),
    Text("게시판"),
    Text("설정 화면"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0, // 아이콘 시작위치
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.orangeAccent,
        color: Colors.black38,
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.easeInOutQuart,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 24, color: Colors.lightBlueAccent),
          Icon(Icons.directions_car, size: 24, color: Colors.lightBlueAccent),
          Icon(Icons.library_books, size: 24, color: Colors.lightBlueAccent),
          Icon(Icons.settings, size: 24, color: Colors.lightBlueAccent)
        ],
      ),
      body: Container(
        child: _selectedMenu.elementAt(_selectedIndex),
      ),
    );
  }

  Future<List<CarModel>> carDataLoad() async {
    DBHelper db = DBHelper();
    return await db.loadData();
  }

  Widget carBuilder() {
    return FutureBuilder(
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData == null) {
          return Container(child: Text('데이터가 없습니다.'),);
        }
        return Container(
          // 데이터가 들어 왔을 경우 처리 List에 데이터 저장
        );
      },
      future: carDataLoad(),
    );
  }
}