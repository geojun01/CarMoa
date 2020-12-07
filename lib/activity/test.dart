import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('화면이동'),),
      body: Container(child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('돌아가기'),
      ),),
    );
  }
}
