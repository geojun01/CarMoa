import 'package:carmoa/activity/camping/sub_view/sub_data_view.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/api_data.dart';
import 'package:carmoa/data/model/item.dart';
import 'package:carmoa/widgets/moa_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NationalPark extends StatefulWidget {
  @override
  _NationalParkState createState() => _NationalParkState();
}

class _NationalParkState extends State<NationalPark> {
  // 마지막 페이지라면 false 처리로 더이상 스크롤 이벤트를 처리 하지 않는다.
  bool _isPageCheck = true;

  // 로딩될 페이지 번호
  int _pageIndex = 1;

  // ApiData 보관
  List<Item> apiData = new List<Item>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getApiData(_pageIndex);
    _scrollController.addListener(
      () {
        if (_isPageCheck) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            ++_pageIndex;
            getApiData(_pageIndex);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoaAppBar(title: '국립공원 관광정보'),
            SizedBox(height: 8),
            Flexible(child: dataImportView()),
          ],
        ),
      ),
    );
  }

  Widget dataImportView() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(6.0),
      itemCount: apiData.length,
      itemBuilder: (context, _index) {
        if (apiData[_index].firstimage != null) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  aniNavigator(
                      context,
                      SubDataView(
                        item: apiData[_index],
                      ));
                },
                child: Row(
                  children: [
                    Hero(
                      tag: 'carMoa${apiData[_index].firstimage}',
                      child: Image.network(
                        apiData[_index].firstimage,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    SizedBox(width: 6),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$_index'),
                        Text(
                          '${apiData[_index].title}',
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                        Text(
                          '${apiData[_index].addr1}',
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  // TODO arrange - 정렬 구분 (A=제목순, B=조회순, C=수정일순, D=생성일순)
  // TODO contentTypeId - 관광타입 - 관광타입(관광지, 숙박 등) ID
  // TODO areaCode - 지역 코드
  // TODO sigunguCode - 시군구코드
  // TODO MobileApp - 어플명
  // TODO pageNo = 현재 페이지
  // TODO numOfRows=5 = 현재 페이지 표시 데이터

  getApiData(int _pageIndex) async {
    ApiData _data;
    String url =
        'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=' +
            apiKey +
            '&contentTypeId=12&areaCode=&sigunguCode=&cat1=A01&cat2=A0101&cat3=A01010100' +
            '&listYN=Y&MobileOS=ETC&MobileApp=AppTesting' +
            '&arrange=A&numOfRows=10&pageNo=$_pageIndex&_type=json';

    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final utf8Data = utf8.decode(response.bodyBytes);
        final responseData = json.decode(utf8Data);
        _data = ApiData.fromJson(responseData);
        setState(() {
          if (_data != null) {
            for (int i = 0; i < _data.response.body.items.item.length; i++) {
              apiData.add(_data.response.body.items.item[i]);
            }
          }
        });
      } else {
        print('${response.hashCode}');
      }
    } catch (e) {
      _isPageCheck = false;
      throw new Exception(e);
    }
  }
}

// Widget dataImportView() {
//   return FutureBuilder<ApiData>(
//     future: getApiData(_pageIndex),
//     builder: (context, snap) {
//       if (snap.hasData) {
//         apiData = snap.data;
//         return ListView.builder(
//           controller: _scrollController,
//           padding: EdgeInsets.all(6.0),
//           itemCount: apiData.response.body.items.item.length,
//           itemBuilder: (context, _index) {
//             //print("인덱스 : $_index");
//             if (apiData.response.body.items.item[_index].firstimage != null) {
//               return Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       aniNavigator(
//                           context,
//                           SubDataView(
//                             item:
//                             apiData.response.body.items.item[_index],
//                           ));
//                     },
//                     child: Row(
//                       children: [
//                         Hero(
//                           tag:
//                               'carMoa${apiData.response.body.items.item[_index].firstimage}',
//                           child: Image.network(
//                             apiData
//                                 .response.body.items.item[_index].firstimage,
//                             width: 80,
//                             height: 80,
//                           ),
//                         ),
//                         SizedBox(width: 6),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${apiData.response.body.items.item[_index].title}',
//                               overflow: TextOverflow.clip,
//                               softWrap: true,
//                             ),
//                             Text(
//                               '${apiData.response.body.items.item[_index].addr1}',
//                               overflow: TextOverflow.clip,
//                               softWrap: true,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(),
//                 ],
//               );
//             } else {
//               return Container();
//             }
//           },
//         );
//       } else if (snap.hasError) {
//         return Center(child: Text('Error : ${snap.hasError}'));
//       } else {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     },
//   );
// }
