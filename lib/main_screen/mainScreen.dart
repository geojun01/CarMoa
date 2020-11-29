import 'package:carmoa/activity/carmoa_home.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/main_screen/drawerScreen.dart';
import 'package:flutter/material.dart';

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
        Tween<double>(begin: 1.0, end: 0.7).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
              right: menuOpen ? deviceWidth * -0.40 : 0.0,
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
              )),
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
