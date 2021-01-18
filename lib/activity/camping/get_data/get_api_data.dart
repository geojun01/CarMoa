import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/api_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// TODO arrange - 정렬 구분 (A=제목순, B=조회순, C=수정일순, D=생성일순)
// TODO contentTypeId - 관광타입 - 관광타입(관광지, 숙박 등) ID
// TODO areaCode - 지역 코드
// TODO sigunguCode - 시군구코드
// TODO MobileApp - 어플명
// TODO pageNo = 현재 페이지
// TODO numOfRows=5 = 현재 페이지 표시 데이터

Future<ApiData> getApiData(int _pageIndex) async {
  String url =
      'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=' +
          apiKey +
          '&contentTypeId=12&areaCode=&sigunguCode=&cat1=A01&cat2=A0101&cat3=A01010100' +
          '&listYN=Y&MobileOS=ETC&MobileApp=AppTesting&arrange=A&numOfRows=10&pageNo=$_pageIndex&_type=json';

  ApiData apiData;
  try {
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final utf8Data = utf8.decode(response.bodyBytes);
      final responseData = json.decode(utf8Data);
      apiData = ApiData.fromJson(responseData);
      print('데이터 로드 : $_pageIndex');
    } else {
      print('${response.hashCode}');
    }
  } catch (e) {
    throw new Exception(e);
  }

  return apiData;
}
