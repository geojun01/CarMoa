import 'dart:convert';

import 'package:carmoa/activity/camping/sub_view/test_sub.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/api_data.dart';
import 'package:carmoa/widgets/moa_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class Camping extends StatefulWidget {
  @override
  _CampingState createState() => _CampingState();
}

class _CampingState extends State<Camping> {
  @override
  Widget build(BuildContext context) {
    // final List<String> _item = [
    //   'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/a.jpg',
    //   'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/b.jpg',
    //   'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/c.jpg',
    //   'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/d.jpg',
    //   'https://raw.githubusercontent.com/sokuri2019/carmoa/main/images/e.jpg',
    // ];
    final List<String> _item = [
      'assets/images/a.jpg',
      'assets/images/b.jpg',
      'assets/images/c.jpg',
      'assets/images/d.jpg',
      'assets/images/e.jpg',
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
    return FutureBuilder<ApiData>(
      future: getApiData(),
      builder: (context, snap) {
        if (snap.hasData) {
          ApiData apiData = snap.data;
          return ListView.builder(
            padding: EdgeInsets.all(6.0),
            itemCount: apiData.response.body.items.item.length,
            itemBuilder: (context, _index) {
              if (apiData.response.body.items.item[_index].firstimage != null) {
                return Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            aniNavigator(
                                context,
                                TestSub(
                                  item:
                                      apiData.response.body.items.item[_index],
                                ));
                          },
                          child: Hero(
                            tag:
                                'carMoa${apiData.response.body.items.item[_index].firstimage}',
                            child: Image.network(
                              apiData
                                  .response.body.items.item[_index].firstimage,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${apiData.response.body.items.item[_index].title}',
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                            Text(
                              '${apiData.response.body.items.item[_index].addr1}',
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              } else {
                return Container();
              }
            },
          );
        } else if (snap.hasError) {
          return Center(child: Text('Error : ${snap.hasError}'));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

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

    // print('확인 : ${apiData.response.body.items.item[0].title}');

    return apiData;
  }
}
