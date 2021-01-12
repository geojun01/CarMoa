import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:carmoa/config/provider/icon_menu.dart';
import 'package:carmoa/config/provider/location.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/config/provider/selected_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

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
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CarMoa',
            theme: ThemeProvider.themeOf(themeContext).data,
            home: MainScreen(),
          ),
        ),
      ),
    );
  }
}