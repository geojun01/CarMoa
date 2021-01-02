import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
Color startColor = Color.fromRGBO(70, 112, 112, 1.0);
Color whiteColor = Color.fromRGBO(239, 247, 255, 1);
Color grayColor = Color.fromRGBO(71, 71, 71, 1);

const mainText14 = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

const titleText16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(217, 254, 207, 1),
);

const titleBoldText18 = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: Color.fromRGBO(48, 96, 96, 1.0),
);

const titleMain15 = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

const titleMinText12 = TextStyle(
  fontSize: 12,
  color: Color.fromRGBO(150, 150, 150, 1),
);

class Styles {
  static File imagePath;
}

bool menuOpen = false;
bool isMenuCheck = false;

List<String> menuItems = [
  '교환주기 설정',
  'Menu page B',
  'Menu page C',
  'Menu page D',
  'Menu page E',
  'CarMoa Information',
];

List<IconData> icons = [
  CupertinoIcons.slider_horizontal_3,
  CupertinoIcons.home,
  CupertinoIcons.plus,
  CupertinoIcons.chart_pie,
  CupertinoIcons.mail,
  CupertinoIcons.info,
];


List<String> modifyType = [
  '엔진오일',
  '에어크리너',
  '와이퍼',
  '타이어',
  '브레이크패드',
  '브레이크오일',
  '배터리',
  '점화플러그',
];

List<String> carIcons = [
  'oil.png',
  'air.png',
  'wiper.png',
  'tire.png',
  'pad.png',
  'oil.png',
  'battery.png',
  'plug.png',
];

List<String> carIconsGray = [
  'oil_b.png',
  'air_b.png',
  'wiper_b.png',
  'tire_b.png',
  'pad_b.png',
  'oil_b.png',
  'battery_b.png',
  'plug_b.png',
];
