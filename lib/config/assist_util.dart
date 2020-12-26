import 'package:carmoa/config/provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Size> viewSize(Stream<Size> source) async {
  await for (Size value in source) {
    if (value != null) {
      return value;
    }
  }
  return null;
}

Future<void> loadPreferenceInt(
    {@required String saveTitle, @required int initValue, @required BuildContext context}) async {
  final item = Provider.of<Model>(context);
  int _settingKm;
  SharedPreferences pref = await SharedPreferences.getInstance();
  _settingKm = pref.getInt(saveTitle) ?? initValue;
  item.setCycleCheck(_settingKm);
}

Future<void> savePreferenceInt(
    {@required String saveTitle, @required int value, @required BuildContext context}) async {
  final item = Provider.of<Model>(context);
  SharedPreferences pres = await SharedPreferences.getInstance();
  pres.setInt(saveTitle, value);
  item.setCycleCheck(value);
}

Future<void> savePreferenceString(
    {@required String saveTitle, @required String name}) async {
  SharedPreferences pres = await SharedPreferences.getInstance();
  pres.setString(saveTitle, name);
}

Future<String> loadPreferenceString({@required String saveTitle}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString(saveTitle) ?? '';
}