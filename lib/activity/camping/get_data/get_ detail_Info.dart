import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/sub_detail_info/detail_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<DetailInfoData> getDetailInfoData(int _id) async {
  String url =
      'http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailInfo?ServiceKey=' +
          apiKey +
          '&contentTypeId=12&contentId=$_id&MobileOS=ETC&MobileApp=AppTesting&listYN=Y&_type=json';

  DetailInfoData detailInfoData;
  try {
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final utf8Data = utf8.decode(response.bodyBytes);
      final responseData = json.decode(utf8Data);
      detailInfoData = DetailInfoData.fromJson(responseData);
    }
  } catch (e) {
    print('DetailInfoData Error : $e');
  }

  return detailInfoData;
}
