
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
const Color startColor = Color.fromRGBO(70, 112, 112, 1.0);
const Color baseColor = Color.fromRGBO(240, 235, 235, 1);
const Color subMenuColor = Color.fromRGBO(51, 63, 63, 1);
const Color iconMenuColor = Color.fromRGBO(236, 228, 228, 1);
const Color primaryMainColor = Color.fromRGBO(43, 139, 229, 1);

const String apiKey = 'hgTO%2F8ISzw%2FmrzX5io6JFznSGyPN5L9ecg74th%2BlsA7kP%2FlPOdR89I%2F%2FAuIM%2BdJ4wGNLDjDyt3EaJpCSWjOagQ%3D%3D';

const mainText = TextStyle(
  fontWeight: FontWeight.w400,
);

const mainText16 = TextStyle(
  fontSize: 16.0,
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
);

const titleMain15 = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

const titleMinText12 = TextStyle(
  fontSize: 12,
  color: Color.fromRGBO(150, 150, 150, 1),
);

bool isIconMenuCheck = false;
bool isMenuCheck = false;

List<String> menuItems = [
  '교환주기 설정',
  'Menu page B',
  'Menu page C',
  'Menu page D',
  '테마변경',
  '오픈소스 정보',
];

List<IconData> icons = [
  CupertinoIcons.slider_horizontal_3,
  CupertinoIcons.home,
  CupertinoIcons.plus,
  CupertinoIcons.chart_pie,
  CupertinoIcons.viewfinder,
  CupertinoIcons.info,
];


List<String> partType = [
  '엔진오일',
  '에어크리너',
  '와이퍼',
  '타이어',
  '브레이크패드',
  '브레이크오일',
  '배터리',
  '점화플러그',
  '부동액',
];

List<String> carIcons = [
  'e_oil.png',
  'air.png',
  'wiper.png',
  'tire.png',
  'pad.png',
  'oil.png',
  'battery.png',
  'plug.png',
  'antifreeze.png'
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
  'antifreeze_b.png'
];
