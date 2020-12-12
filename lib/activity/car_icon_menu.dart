import 'package:carmoa/activity/test.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/icon_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CarIconMenu extends StatelessWidget {
  const CarIconMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<IconMenu>(context);
    //var w = MediaQuery.of(context).size.width;
    double h = 80;

    return Row(
      children: [
        Expanded(
          flex: menu.getMenuA(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: menu.getMenuIndex() == 1
                ? Colors.orange
                : Colors.grey.withOpacity(0.9),
            curve: Curves.linear,
            // width: w * menu.getMenuA(),
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  menu.menuSelect(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.crow,
                      size: menu.getMenuIndex() == 1 ? 50 : 30,
                      color: menu.getMenuIndex() == 1
                          ? Colors.white70
                          : Colors.black54,
                    ),
                    SizedBox(height: 6),
                    Text('캠핑 감성',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: menu.getMenuB(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: menu.getMenuIndex() == 2
                ? Colors.orange
                : Colors.grey.withOpacity(0.7),
            curve: Curves.linear,
            // width: w * menu.getMenuB(),
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  menu.menuSelect(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.chargingStation,
                      size: menu.getMenuIndex() == 2 ? 50 : 30,
                      color: menu.getMenuIndex() == 2
                          ? Colors.white70
                          : Colors.black54,
                    ),
                    SizedBox(height: 6),
                    Text('전기 충전소',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
        //menuOpen ? Expanded(flex: 1, child: Container()) : buildAnimatedContainer(menu, w, context),
        Expanded(
          flex: menu.getMenuC(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: menu.getMenuIndex() == 3
                ? Colors.orange
                : Colors.grey.withOpacity(0.5),
            curve: Curves.linear,
            // width: w * menu.getMenuC(),
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  menu.menuSelect(3);
                  Future.delayed(
                      Duration(milliseconds: 300),
                          () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Test()))
                      });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.sms,
                      size: menu.getMenuIndex() == 3 ? 50 : 30,
                      color: menu.getMenuIndex() == 3
                          ? Colors.white70
                          : Colors.black54,
                    ),
                    SizedBox(height: 6),
                    Text('게시판',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  AnimatedContainer buildAnimatedContainer(IconMenu menu, double w, BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: menu.getMenuIndex() == 3
            ? Colors.orange
            : Colors.grey.withOpacity(0.5),
        curve: Curves.linear,
        width: w * menu.getMenuC(),
        height: 100,
        child: Center(
          child: InkWell(
            onTap: () {
              menu.menuSelect(3);
              Future.delayed(
                  Duration(milliseconds: 300),
                  () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Test()))
                      });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.sms,
                  size: menu.getMenuIndex() == 3 ? 50 : 30,
                  color: menu.getMenuIndex() == 3
                      ? Colors.white70
                      : Colors.black54,
                ),
                SizedBox(height: 6),
                Text('게시판',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      );
  }
}
