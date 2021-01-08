import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:carmoa/config/provider/icon_menu.dart';
import 'package:carmoa/config/provider/location.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/config/provider/selected_menu.dart';
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
        ChangeNotifierProvider<Location>(create: (_) => Location()),
        ChangeNotifierProvider<Cycle>(create: (_) => Cycle()),
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
        primaryColor: primaryMainColor,
      ),
      home: MainScreen(),
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Provider.of<SelectMenu>(context, listen: false);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'CarMoa',
//       theme: theme.getTheme(),
//       home: themeSet(context),
//     );
//   }
// }
//
// Widget themeSet(BuildContext context) {
//   themeLoad(context);
//   ThemeData(primaryColor: primaryMainColor);
//   return MainScreen();
// }
//
// // 테마 불러오기
// Future<void> themeLoad(BuildContext context) async {
//   String eng = await loadPreferenceString(loadTitle: 'theme', value: 'dark');
//
//   if (eng != null) themeChange(context, eng);
// }
//
// void themeChange(BuildContext context, String _theme) {
//   final theme = Provider.of<SelectMenu>(context, listen: false);
//
//   if (_theme == 'light') {
//     theme.setTheme(ThemeData.light());
//     theme.setThemeName(_theme);
//     menuItems[4] = 'Light Theme Mode';
//   } else {
//     theme.setTheme(ThemeData.dark());
//     theme.setThemeName(_theme);
//     menuItems[4] = 'Dark Theme Mode';
//   }
// }