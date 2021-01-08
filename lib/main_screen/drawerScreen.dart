import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/sub_screen/cycle_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int selectedMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(106, 128, 127, 1),
              Color.fromRGBO(19, 61, 70, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child:
                      Image.asset('assets/images/car.png', fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // login Image & Name
                    Row(
                      children: [
                        Hero(
                          tag: 'logoImage',
                          child: CircleAvatar(
                            radius: 22.0,
                            backgroundImage:
                                AssetImage('assets/images/logo.jpg'),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jungle(정글)',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            Text('jungle@gmail.com',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Expanded(child: Container()),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 메뉴 모음
                    Column(
                      children: menuItems
                          .asMap()
                          .entries
                          .map((mapEntry) => buildMenuRow(mapEntry.key))
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    // Setting & log Out
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.cog,
                          color: Colors.white.withOpacity(0.5),
                          size: 16.0,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Log out',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16.0,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Copyright © & STUDIO JUNGLE. All Rights Reserved',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          FlatButton(
            onPressed: () {
              setState(() {
                selectedMenuIndex = index;
                selectMenu(context, selectedMenuIndex);
              });
            },
            child: Row(
              children: [
                Icon(
                  icons[index],
                  color: selectedMenuIndex == index
                      ? Colors.orangeAccent
                      : subMenuColor,
                  size: 16,
                ),
                SizedBox(width: 16.0),
                Text(
                  menuItems[index],
                  style: TextStyle(
                      color: selectedMenuIndex == index
                          ? Colors.white
                          : subMenuColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void selectMenu(BuildContext context, int index) {
  switch (index) {
    case 0:
      aniNavigator(context, CycleSetting());
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      //themeChcek(context);
      break;
    case 5:
      aniNavigator(context, LicensePage());
      break;
  }
}

// void themeChcek(BuildContext context) {
//   final theme = Provider.of<SelectMenu>(context, listen: false);
//
//   if (theme.getThemeName() == 'light') {
//     theme.setThemeName('dark');
//     theme.setTheme(ThemeData.dark());
//     menuItems[4] = 'Dark Theme Mode';
//   } else {
//     theme.setThemeName('light');
//     theme.setTheme(ThemeData.light());
//     menuItems[4] = 'Light Theme Mode';
//   }
// }
