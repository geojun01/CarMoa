import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/sub_image_model/sub_image_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<SubImageData> getApiData(int _id) async {
  final url =
      'http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailImage?' +
          'ServiceKey=$apiKey' +
          '&contentTypeId=12&MobileOS=ETC&MobileApp=AppTesting&contentId=$_id&imageYN=Y&_type=json';

  SubImageData subImageData;
  try {
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      subImageData = SubImageData.fromJson(responseData);
    }
  } catch (e) {
    print('Exception - $e');
  }

  return subImageData;
}