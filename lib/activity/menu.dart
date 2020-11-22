import 'package:carmoa/activity/car.dart';
import 'package:carmoa/activity/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _selectedIndex = 0;

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
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.orangeAccent,
        color: Colors.white10,
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.easeInOutQuart,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 24, color: Colors.white),
          Icon(Icons.directions_car, size: 24, color: Colors.white),
          Icon(Icons.library_books, size: 24, color: Colors.white),
          Icon(Icons.settings, size: 24, color: Colors.white)
        ],
      ),
      body: Container(
        child: _selectedMenu.elementAt(_selectedIndex),
      ),
    );
  }
}
