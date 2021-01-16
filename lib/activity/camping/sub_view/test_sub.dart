import 'dart:convert';
import 'package:carmoa/data/model/item.dart';
import 'package:carmoa/data/sub_image_model/sub_image_data.dart';
import 'package:carmoa/widgets/fade_in_ainmation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestSub extends StatelessWidget {
  final Item item;

  TestSub({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: 'carMoa${item.firstimage}',
                  child: Image.network(item.firstimage),
                ),
                SizedBox(height: 8),
                buildImage(),
                SizedBox(height: 8),
                MyWidget(),
              ],
            ),
          ),
          Positioned(
            top: 36,
            left: 10,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.arrow_left_circle,
                  size: 26,
                  color: Colors.deepOrangeAccent,
                )),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return FutureBuilder<SubImageData>(
        future: getApiData(item.contentid),
        builder: (context, snap) {
          SubImageData subApi = snap.data;
          if (snap.hasData) {
            return Container(
              height: 80,
              child: FadeIn(
                delay: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subApi.response.body.items.item.length,
                  itemBuilder: (context, _index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Image.network(
                          subApi.response.body.items.item[_index].smallimageurl),
                    );
                  },
                ),
              ),
            );
          } else if (snap.hasError) {
            return Center(
              child: Text('Error : ${snap.hasError}'),
            );
          } else if (snap.data == null) {
            return Container();
          } else
            return Center(child: Text('자료가 없습니다.'));
        });
  }

  Future<SubImageData> getApiData(int _id) async {
    final url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailImage?' +
        'ServiceKey=hgTO%2F8ISzw%2FmrzX5io6JFznSGyPN5L9ecg74th%2BlsA7kP%2FlPOdR89I%2F%2FAuIM%2BdJ4wGNLDjDyt3EaJpCSWjOagQ%3D%3D' +
        '&contentTypeId=12&MobileOS=ETC&MobileApp=AppTesting&contentId=${_id.toString()}&imageYN=Y&_type=json';

    SubImageData subImageData;
    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final utf8Data = utf8.decode(response.bodyBytes);
        final responseData = json.decode(utf8Data);
        subImageData = SubImageData.fromJson(responseData);
      } else {
        print('Error ${response.hashCode}');
      }
    } catch (e) {
      print('Error : $e');
    }

    // print('확인 : ${apiData.response.body.items.item[0].title}');

    return subImageData;
  }
}

class MyWidget extends StatelessWidget {
  final List data = [
    '09:00 am - 10:00 am',
    '10:00 am - 11:00 am',
    '11:00 am - 12:00 am',
    '12:00 am - 01:00 am',
    '01:00 am - 02:00 am',
    '02:00 am - 03:00 am',
    '03:00 am - 04:00 am',
    '04:00 am - 05:00 am'
  ];

  List<Widget> textWidgetList = List<Widget>();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 8; i++) {
      textWidgetList.add(
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data[i],
                ),
              ),
              i <= data.length - 2 ? Divider() : Container(),
            ],
          ),
        ),
      );
    }
    return Container(
        child: Column(
      children: textWidgetList,
    ));
  }
}
