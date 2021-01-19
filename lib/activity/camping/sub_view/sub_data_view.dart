import 'package:carmoa/activity/camping/get_data/get_%20detail_Info.dart';
import 'package:carmoa/activity/camping/get_data/sub_image_list_get.dart';
import 'package:carmoa/activity/camping/sub_view/sub_detail_image_view.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/data/model/item.dart';
import 'package:carmoa/data/sub_detail_info/detail_info.dart';
import 'package:carmoa/data/sub_image_model/sub_image_data.dart';
import 'package:carmoa/widgets/fade_in_ainmation.dart';
import 'package:carmoa/widgets/image_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(45, 45, 45, 1),
                                  offset: Offset(0, 1),
                                  blurRadius: 2)
                            ],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: ImageNetwork(url: item.firstimage)),
                      ),
                    ),
                    SizedBox(height: 8),
                    buildImage(),
                    SizedBox(height: 8),
                    detailInfoData(),
                    // 라이센스 표시
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Licence : 공공데이터포털 / 한국관광공사',
                          style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: _size != null ? _size.height * 0.05 : 0,
                left: _size != null ? _size.height * 0.01 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              CupertinoIcons.chevron_left,
                              size: 26,
                              color: Colors.deepOrangeAccent,
                            ),
                          )),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '${item.title}',
                      style:
                          TextStyle(fontSize: 20, color: baseColor, shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black87,
                          offset: Offset(0, 1.0),
                        ),
                      ]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
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
                  return InkWell(
                    onTap: () {
                      aniNavigator(context,
                          DetailImageView(subImage: subApi, title: item.title));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ]),
                        child: Image.network(subApi
                            .response.body.items.item[_index].smallimageurl),
                      ),
                    ),
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
      },
    );
  }

  // Text 정보 Widget 단위 그룹화
  Widget detailInfoData() {
    return FutureBuilder<DetailInfoData>(
      future: getDetailInfoData(item.contentid),
      builder: (context, snapShop) {
        DetailInfoData detailInfoData = snapShop.data;
        List<Widget> textWidgetList = List<Widget>();
        if (snapShop.hasData) {
          for (int i = 0;
              i < detailInfoData.response.body.items.item.length;
              i++) {
            textWidgetList.add(Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                              data: detailInfoData
                                  .response.body.items.item[i].infoname),
                          Html(
                              data: detailInfoData
                                  .response.body.items.item[i].infotext)
                        ],
                      ),
                    ),
                    i <= detailInfoData.response.body.items.item.length - 2
                        ? Divider(thickness: 2)
                        : Container(),
                  ]),
            ));
          }
          return Container(
            child: Column(
              children: textWidgetList != null
                  ? textWidgetList.toList()
                  : Container(),
            ),
          );
        } else
          return Container();
      },
    );
  }
}
