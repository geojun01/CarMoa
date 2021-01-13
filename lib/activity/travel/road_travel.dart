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
        isIconMenuCheck = false;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

  Widget _appTitle() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(42, 139, 229, 1),
            Color.fromRGBO(25, 103, 182, 1)
          ],
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  isIconMenuCheck = false;
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(CupertinoIcons.arrow_left_circle,size: 26 ,color: baseColor),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              '아름다운 길',
              style: TextStyle(fontSize: 20, color: baseColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
