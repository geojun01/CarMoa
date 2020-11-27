import 'package:carmoa/activity/carmoa_home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: MoaHome(),
        ));
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
