import 'package:carmoa/config/config_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoadTravel extends StatefulWidget {
  @override
  _RoadTravelState createState() => _RoadTravelState();
}

class _RoadTravelState extends State<RoadTravel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        menuOpen = false;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                _appTitle(),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: _bodyColumn(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyColumn() {
    return Column(
      children: [Text('아름다운 길')],
    );
  }

  Container _appTitle() {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              menuOpen = false;
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(CupertinoIcons.back, size: 24),
            ),
          ),
          Expanded(child: Container()),
          Text(
            '아름다운 길',
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: Container()),
          SizedBox(width: 36),
        ],
      ),
    );
  }
}
