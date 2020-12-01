import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/selected_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<SelectMenu>(create: (_) => SelectMenu())
          ],
          child: MainScreen(),
        ));
  }

}
