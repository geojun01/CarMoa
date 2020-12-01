import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
Color startColor = Color.fromRGBO(70, 112, 112, 1.0);

const mainFont = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: Colors.black54,
);

const titleBoldFont = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(48, 96, 96, 1.0),
);

const titleMain = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);

const titleMinFont = TextStyle(
  fontSize: 12,
  color: Color(0xFFB0BEC5),
);

class Styles {
  static File imagePath;
}

bool menuOpen = false;

List<String> menuItems = [
  '교환주기 설정',
  'Menu page B',
  'Menu page C',
  'Menu page D',
  'Menu page E',
  'Menu page F',
];

List<IconData> icons = [
  FontAwesomeIcons.slidersH,
  FontAwesomeIcons.home,
  FontAwesomeIcons.plus,
  FontAwesomeIcons.heart,
  FontAwesomeIcons.envelope,
  FontAwesomeIcons.userAlt,
];


List<String> modifyType = [
  '엔진오일',
  '에어크리너',
  '타이어',
  '브레이크패드',
  '브레이크오일',
];

List<IconData> animalIcons = [
  FontAwesomeIcons.cat,
  FontAwesomeIcons.dog,
  FontAwesomeIcons.crow,
  FontAwesomeIcons.fish,
  FontAwesomeIcons.paw,
];