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

class Camping extends StatefulWidget {
  @override
  _CampingState createState() => _CampingState();
}

class _CampingState extends State<Camping> {
  // 로딩 페이지가 끝이라면 false 처리로 더이상 스크롤 이벤트를 처리 하지 않는다.
  bool _isPageCheck = true;

  // 로딩될 페이지 번호
  int _pageIndex = 1;

  // 가져온 데이터 보관
  List<Item> apiData = new List<Item>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getApiData(_pageIndex);
    _scrollController.addListener(() {
      if (_isPageCheck) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ++_pageIndex;
          getApiData(_pageIndex);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _item = [
      'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/a.jpg',
      'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/b.jpg',
      'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/c.jpg',
      'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/d.jpg',
      'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/e.jpg',
    ];
    final List<String> _itemText = [
      '대전 계족산',
      '보성 녹차밭',
      '우도',
      '창녕 우포늪',
      '충북 단양 보발재',
    ];

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Size>(
          future: viewSize(Stream<Size>.periodic(
              Duration(milliseconds: 100), (i) => MediaQuery.of(context).size)),
          builder: (context, snap) {
            //Size _size = snap.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoaAppBar(title: '구석구석'),
                //_appTitle(),
                // SizedBox(height: 8),
                // sliderImageView(_item, _itemText),
                SizedBox(height: 8),
                Flexible(child: dataImportView()),
              ],
            );
          },
        ),
      ),
    );
  }

  Container sliderImageView(List<String> _item, List<String> _itemText) {
    return _item != null
        ? Container(
            height: 200,
            child: Swiper(
              autoplay: true,
              autoplayDelay: 10000,
              curve: Curves.easeIn,
              itemCount: _item.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  //borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image(
                        // image: NetworkImage(_item[index]),
                        image: AssetImage(_item[index]),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 20,
                        top: 10,
                        child: Text(
                          '${_itemText[index]}',
                          style: TextStyle(
                            color: baseColor,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              viewportFraction: 0.8,
              scale: 0.9,
              pagination: SwiperPagination(),
              layout: SwiperLayout.DEFAULT,
            ),
          )
        : CircularProgressIndicator();
  }

  Widget dataImportView() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(6.0),
      itemCount: apiData.length,
      itemBuilder: (context, _index) {
        //print("인덱스 : $_index");
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
    String url =
        'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=' +
            apiKey +
            '&contentTypeId=12&areaCode=&sigunguCode=&cat1=A01&cat2=A0101&cat3=A01010100' +
            '&listYN=Y&MobileOS=ETC&MobileApp=AppTesting&arrange=A&numOfRows=10&pageNo=$_pageIndex&_type=json';

    ApiData _data;
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
