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

String datePast(String startDate) {
  try {
    if (startDate == '초기상태') return '초기상태';
    final sDate = DateTime.parse(startDate);

    var days = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(
      DateTime(
        sDate.year, sDate.month, sDate.day
      )
    ).inDays;

    String lastDate = days.toString() + ' 일';

    if (days.toString() == "0") {
      return '오늘교환';
    } else return lastDate;
  } catch (e){
    print('예외처리 : $e');
  }
  return null;
}


// startDate -> 데이터 베이스에 저장된 날짜를 오늘 날짜와 비교해 경과 시간을 구해낸다.
// String DatePast(String startDate) {
//   try {
//     // 데이터가 없으면 처리
//     if (startDate.equals("초기상태")) {
//       return "초기상태";
//     }
//     // 날짜를 date타입으로 변경
//     @SuppressLint("SimpleDateFormat") SimpleDateFormat fm = new SimpleDateFormat("yyyy년 MM월 dd일");
//     long now = System.currentTimeMillis();
//     Date eDate = new Date(now);
//     Date sDate = fm.parse(startDate);
//
//     // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
//     long diff = eDate.getTime() - sDate.getTime();
//     long diffDays = diff / (24 * 60 * 60 * 1000);
//
//     // 개월수 구하기
//     long allMonth1 = (diffDays + 1) / 30;
//     int aa = (int)(allMonth1 * 30.417);
//
//     if (diffDays == 0) {
//       day = "오늘 교환";
//       return day;
//     } else if (allMonth1 == 0) {
//       day = diffDays + "일 경과";
//       return day;
//     }
//     if (allMonth1 > 0) {
//       if (diffDays < aa) {
//         allMonth1 = allMonth1 - 1;
//         aa = (int) (allMonth1 * 30.417);
//         if ((int) (diffDays - (aa + 1)) <= 0) {
//           day = allMonth1 + "개월 경과";
//         } else {
//           day = allMonth1 + "개월 " + (int) (diffDays - (aa + 1)) + "일 경과";
//         }
//       } else if (diffDays > aa) {
//         aa = (int) (allMonth1 * 30.417);
//         if ((int) (diffDays - (aa + 1)) <= 0) {
//           day = allMonth1 + "개월 경과";
//         } else {
//           day = allMonth1 + "개월 " + (int) (diffDays - (aa + 1)) + "일 경과";
//         }
//       }
//     }
//
//
//   } catch (Exception e) {
//   e.printStackTrace();
//   // 에러 발생시 밑에 로그 체크 확인
//   Log.e("Log", "체크 : " + e.toString());
//   }
//   return day;
// }
//
// // 두 날짜 비교 경과 시간 계산 startDate : 앞 교환 날짜 / endDate : 최근 교환 날짜
// public String DateCheck(String startDate, String endDate) {
//   try {
//     // 시작날짜
//     // 마지막 날짜
//     if (startDate.equals("초기상태")) {
//       return "초기상태";
//     }
//
//     // 날짜를 data타입으로 변경
//     @SuppressLint("SimpleDateFormat") SimpleDateFormat fm = new SimpleDateFormat("yyyy년 MM월 dd일");
//     Date eDate = fm.parse(endDate);
//     Date sDate = fm.parse(startDate);
//
//     // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
//     long diff = eDate.getTime() - sDate.getTime();
//     long diffDays = diff / (24 * 60 * 60 * 1000);
//
//     long allMonth1 = (diffDays + 1) / 30;
//     int aa = (int)(allMonth1 * 30.417);
//
//     if (diffDays == 0) {
//       day = "1일 이내";
//       return day;
//     } else if (allMonth1 == 0) {
//       day = diffDays + "일";
//       return day;
//     }
//     if (allMonth1 > 0) {
//       if (diffDays < aa) {
//         allMonth1 = allMonth1 - 1;
//         aa = (int) (allMonth1 * 30.417);
//         if ((int) (diffDays - (aa + 1)) <= 0) {
//           day = allMonth1 + "개월";
//         } else {
//           day = allMonth1 + "개월 " + (int) (diffDays - (aa + 1)) + "일";
//         }
//       } else if (diffDays > aa) {
//         aa = (int) (allMonth1 * 30.417);
//         if ((int) (diffDays - (aa + 1)) <= 0) {
//           day = allMonth1 + "개월";
//         } else {
//           day = allMonth1 + "개월 " + (int) (diffDays - (aa + 1)) + "일";
//         }
//       }
//     }
//
//   } catch (Exception e) {
//   e.printStackTrace();
//   // 에러 발생시 밑에 로그 체크 확인
//   Log.e("Log", "체크 : " + e.toString());
//   }
//   return day;
// }