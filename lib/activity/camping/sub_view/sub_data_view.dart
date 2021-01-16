import 'package:carmoa/activity/camping/get_data/sub_image_list_get.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/item.dart';
import 'package:carmoa/data/sub_image_model/sub_image_data.dart';
import 'package:carmoa/widgets/fade_in_ainmation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubDataView extends StatelessWidget {
  final Item item;

  SubDataView({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewSize(Stream<Size>.periodic(
          Duration(milliseconds: 100), (i) => MediaQuery.of(context).size)),
      builder: (context, snapShot) {
        Size _size = snapShot.data;
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
                    SizedBox(height: 4),
                    buildImage(),
                    SizedBox(height: 8),
                    MyWidget(),
                  ],
                ),
              ),
              Positioned(
                top: _size != null ? _size.height * 0.05 : 0,
                left: _size != null ? _size.height * 0.01 : 0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          CupertinoIcons.left_chevron,
                          size: 26,
                          color: Colors.deepOrangeAccent,
                        ),
                      )),
                ),
              ),
              Positioned(
                  top: _size != null ? _size.height * 0.048 : 0,
                  left: _size != null ? _size.height * 0.08 : 0,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      '${item.title}',
                      style:
                          TextStyle(fontSize: 20, color: baseColor,shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black87,
                          offset: Offset(0, 1.0),
                        ),
                      ]),overflow: TextOverflow.ellipsis,
                    ),
                  ))
            ],
          ),
        );
      },
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
                    return Card(
                      elevation: 1,
                      child: Image.network(subApi
                          .response.body.items.item[_index].smallimageurl),
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
}

// 최종 외부 위젯 class 로 분리 저장
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
