import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/widgets/moa_appbar.dart';
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
                MoaAppBar(title: '아름다운 길'),
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
}
