import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 스마트폰의 화면 사이즈 구하기
Future<Size> viewSize(Stream<Size> source) async {
  await for (Size value in source) {
    if (value != null) {
      return value;
    }
  }
  return null;
}

// 천단위 콤마 표시
String changeUnit(int _distance) => NumberFormat('###,###,###').format(_distance);

// 경과 날짜 계산
String datePast(String startDate) {
  String lastDate;
  var month, day;
  try {
    if (startDate == '초기상태') return '초기상태';
    final sDate = DateTime.parse(startDate);

    var days =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .difference(DateTime(sDate.year, sDate.month, sDate.day))
            .inDays;

    month = (days / 30.417).floor();
    day = (days % 30.417).floor();

    if (days <= 30) {
      lastDate = '$days 일 경과';
    } else {
      if (day == 0) {
        lastDate = '$month 개월 경과';
      } else {
        lastDate = '$month 개월 $day 일 경과';
      }
    }

    if (days.toString() == "0") {
      return '오늘교환';
    } else
      return lastDate;
  } catch (e) {
    print('예외처리 : $e');
  }
  return null;
}

// 애니메이션 네비게이터
// Widget _widget => 네비게이터 될 class 이름
Future<Object> aniNavigator(BuildContext context, Widget _widget) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, animationTime) => _widget,
      transitionsBuilder: (context, animation, animationTime, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
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

Future<String> loadPreferenceString({@required String loadTitle, @required String value}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString(loadTitle) ?? value;
}
