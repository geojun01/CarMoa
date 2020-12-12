import 'package:carmoa/config/config_style.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/icon_menu.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/model.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/selected_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_screen/mainScreen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectMenu>(create: (_) => SelectMenu()),
        ChangeNotifierProvider<Model>(create: (_) => Model()),
        ChangeNotifierProvider<IconMenu>(create: (_) => IconMenu()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarMoa',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: mainColor,
      ),
      home: MainScreen(),
    );
  }
}
