import 'package:carmoa/activity/carmoa_home.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/icon_menu.dart';
import 'package:carmoa/main_screen/drawerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> scaleAnimation;
  Duration duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1, end: 0.6).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    // WillPopScope = 뒤로가기 종료 이벤트를 처리하기 위한 위젯
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(
        children: [
          DrawerScreen(),
          AnimatedPositioned(
            duration: duration,
            top: 0,
            bottom: 0,
            left: menuOpen ? deviceWidth * 0.50 : 0.0,
            right: menuOpen ? deviceWidth * -0.35 : 0.0,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: MoaHome(
                menuCallback: () {
                  setState(() {
                    menuOpen = !menuOpen;
                    if (menuOpen)
                      _animationController.forward();
                    else
                      _animationController.reverse();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 뒤로가기 버튼 종료 처리
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 4,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.indigo,
            ),
            SizedBox(width: 10),
            Text('프로그램을 종료 합니다.')
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('취소'),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('종료'),
          ),
        ],
      ),
    );
  }
}
