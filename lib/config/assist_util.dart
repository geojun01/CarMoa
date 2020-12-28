import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Size> viewSize(Stream<Size> source) async {
  await for (Size value in source) {
    if (value != null) {
      return value;
    }
  }
  return null;
}

Future<int> loadPreferenceInt(
    {@required String saveTitle, @required int initValue}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(saveTitle) ?? initValue;
}

Future<void> savePreferenceInt(
    {@required String saveTitle, @required int value}) async {
  SharedPreferences pres = await SharedPreferences.getInstance();
  pres.setInt(saveTitle, value);
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