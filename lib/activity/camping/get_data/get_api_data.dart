import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/api_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ApiData> getApiData() async {
  String url =
      'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=' +
          apiKey +
          '&contentTypeId=12&areaCode=&sigunguCode=&cat1=A01&cat2=A0101&cat3=A01010100&listYN=Y&MobileOS=ETC&MobileApp=AppTesting&arrange=A&numOfRows=4&pageNo=1&_type=json';

  ApiData apiData;
  try {
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final utf8Data = utf8.decode(response.bodyBytes);
      final responseData = json.decode(utf8Data);
      apiData = ApiData.fromJson(responseData);
    } else {
      print('${response.hashCode}');
    }
  } catch (e) {
    print('Error : $e');
    return null;
  }

  return apiData;
}