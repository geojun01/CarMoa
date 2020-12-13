import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildTopWeather(BuildContext context) {
  var w = MediaQuery.of(context).size.width;

  return Container(
    width: w * 0.85,
    height: 80,
    decoration: BoxDecoration(
      color: Color.fromRGBO(228, 228, 228, 1),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[500],
            offset: Offset(4.0, 4.0),
            blurRadius: 14.0,
            spreadRadius: 1.0),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 14.0,
            spreadRadius: 1.0),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(weatherIcons[10], color: Colors.cyan),
            SizedBox(width: 20),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Theme.of(context).primaryColor,
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              '완월동 현재 날씨 정보',
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).primaryColor),
            )
          ],
        ),
        SizedBox(height: 6),
        Text('대체로 구름이 조금 끼고 바람이 많이 불 예정',
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).primaryColor))
      ],
    ),
  );
}
