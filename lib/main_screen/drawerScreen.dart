import 'package:carmoa/config/config_style.dart';
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
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 15.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // login Image & Name
                Row(
                  children: [
                    Hero(
                      tag: 'logoImage',
                      child: CircleAvatar(
                        radius: 22.0,
                        backgroundImage: AssetImage('assets/images/logo.jpg'),
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10)
                  ],
                ),
                // 메뉴 모음
                Column(
                  children: menuItems
                      .asMap()
                      .entries
                      .map((mapEntry) => buildMenuRow(mapEntry.key))
                      .toList(),
                ),
                // Setting & log Out
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.cog,
                      color: Colors.white.withOpacity(0.5),
                      size: 16.0,
                    ),
                    SizedBox(width: 16.0),
                    FlatButton(
                      onPressed: () {},
                      child: Text('Setting',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16.0,
                          )),
                    ),
                    SizedBox(width: 20),
                    Text('|',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16.0,
                        )),
                    SizedBox(width: 20),
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
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [startColor, mainColor],
          ),
        ),
      ),
    );
  }

  Widget buildMenuRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          FlatButton(
            onPressed: () {
              setState(() {
                selectedMenuIndex = index;
              });
            },
            child: Row(
              children: [
                Icon(
                  icons[index],
                  color: selectedMenuIndex == index
                      ? Colors.orangeAccent
                      : Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 16.0),
                Text(
                  menuItems[index],
                  style: TextStyle(
                      color: selectedMenuIndex == index
                          ? Colors.white
                          : Colors.grey,
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
