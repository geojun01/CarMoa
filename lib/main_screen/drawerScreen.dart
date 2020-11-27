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

  Widget buildMenuRow(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMenuIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            Icon(
              icons[index],
              color: selectedMenuIndex == index ? Colors.white : Colors.grey,
              size: 16,
            ),
            SizedBox(width: 16.0),
            Text(
              menuItems[index],
              style: TextStyle(
                  color:
                      selectedMenuIndex == index ? Colors.white : Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

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
                    CircleAvatar(
                      radius: 24.0,
                      backgroundColor: Colors.orange,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ryan',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        Text('Active status',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w400)),
                      ],
                    )
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
                    Text('Setting | Log out',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16.0,
                        ))
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
            colors: [startingColor, mainColor],
          ),
        ),
      ),
    );
  }
}
