import 'package:carmoa/activity/board/board_home.dart';
import 'package:carmoa/activity/gasmap/gas_map.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/icon_menu.dart';
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

    double h = 70;

    return Row(
      children: [
        // 메뉴 01
        Expanded(
          flex: menu.getMenuA(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: menu.getMenuIndex() == 1
                        ? [Colors.deepOrangeAccent, Colors.orangeAccent]
                        : [Colors.grey, Colors.grey.withOpacity(0.5)])),
            curve: Curves.linear,
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  if (!menuOpen) {
                    menu.menuSelect(1);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.crow,
                      size: menu.getMenuIndex() == 1 ? 40 : 24,
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
        // 메뉴 02
        Expanded(
          flex: menu.getMenuB(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: menu.getMenuIndex() == 2
                        ? [Colors.deepOrangeAccent, Colors.orangeAccent]
                        : [Colors.grey, Colors.grey.withOpacity(0.5)])),
            curve: Curves.linear,
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  if (!menuOpen) {
                    menu.menuSelect(2);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.route,
                      size: menu.getMenuIndex() == 2 ? 40 : 24,
                      color: menu.getMenuIndex() == 2
                          ? Colors.white70
                          : Colors.black54,
                    ),
                    SizedBox(height: 6),
                    Text('아름다운 길',
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
        // 메뉴 03
        Expanded(
          flex: menu.getMenuC(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: menu.getMenuIndex() == 3
                        ? [Colors.deepOrangeAccent, Colors.orangeAccent]
                        : [Colors.grey, Colors.grey.withOpacity(0.5)])),
            curve: Curves.linear,
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  if (!menuOpen) {
                    menu.menuSelect(3);
                    Future.delayed(
                      Duration(milliseconds: 100),
                      () => {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, animationTime) =>
                              GasMap(),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeIn;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ))
                      },
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.chargingStation,
                      size: menu.getMenuIndex() == 3 ? 40 : 24,
                      color: menu.getMenuIndex() == 3
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
        // 메뉴 04
        Expanded(
          flex: menu.getMenuD(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: menu.getMenuIndex() == 4
                        ? [Colors.deepOrangeAccent, Colors.orangeAccent]
                        : [Colors.grey, Colors.grey.withOpacity(0.5)])),
            curve: Curves.linear,
            height: h,
            child: Center(
              child: InkWell(
                onTap: () {
                  if (!menuOpen) {
                    menu.menuSelect(4);
                    Future.delayed(
                      Duration(milliseconds: 100),
                      () => {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, animationTime) =>
                              BoardHome(),
                          transitionsBuilder:
                              (context, animation, animationTime, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeIn;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ))
                      },
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.sms,
                      size: menu.getMenuIndex() == 4 ? 40 : 24,
                      color: menu.getMenuIndex() == 4
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
}
