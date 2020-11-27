import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
Color startingColor = Color.fromRGBO(70, 112, 112, 1.0);

const mainFont = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const titleBoldFont = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  color: Brightness.light == null ? Colors.white : Colors.black,
);

const titleMinFont = TextStyle(
  fontSize: 12,
  color: Color(0xFFB0BEC5),
);

class Styles {
  static File imagePath;
}

List<String> menuItems = [
  'Adoption',
  'Donation',
  'Add pet',
  'Favorites',
  'Messages',
  'Profile',
];

List<IconData> icons = [
  FontAwesomeIcons.paw,
  FontAwesomeIcons.home,
  FontAwesomeIcons.plus,
  FontAwesomeIcons.heart,
  FontAwesomeIcons.envelope,
  FontAwesomeIcons.userAlt,
];
