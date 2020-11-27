import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'main_screen/mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarMoa',
      theme: ThemeData(
        primaryColor: mainColor,
      ),
      home: MainScreen()
    );
  }
}
