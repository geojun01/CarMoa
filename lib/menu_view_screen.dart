import 'package:carmoa/activity/home.dart';
import 'package:carmoa/activity/setting.dart';
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

  // 하단 바 메뉴 list dfd
  List _selectedMenu = [
    Home(),
    Car(),
    SafeArea(child: Text("게시판")),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0, // 아이콘 시작위치
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0XFFCFD8DC),
        color: Colors.black.withOpacity(0.2),
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.easeInOutQuart,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 24, color: Colors.indigo),
          Icon(Icons.directions_car, size: 24, color: Colors.indigo),
          Icon(Icons.library_books, size: 24, color: Colors.indigo),
          Icon(Icons.settings, size: 24, color: Colors.indigo)
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