import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

    return WillPopScope(
      onWillPop: () async {
        isIconMenuCheck = false;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: FutureBuilder<Size>(
              future: viewSize(Stream<Size>.periodic(
                  Duration(milliseconds: 100),
                  (i) => MediaQuery.of(context).size)),
              builder: (context, snap) {
                Size _size = snap.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    _appTitle(),
                    Divider(),
                    Container(
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
                                    image: AssetImage(_item[index]),
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                      left: 20,
                                      top: 10,
                                      child: Text(
                                        '${_itemText[index]}',
                                        style: TextStyle(color: baseColor, fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ));
                        },
                        viewportFraction: 0.8,
                        scale: 0.9,
                        pagination: SwiperPagination(),
                        layout: SwiperLayout.DEFAULT,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _appTitle() {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              isIconMenuCheck = false;
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(CupertinoIcons.back, size: 24),
            ),
          ),
          Expanded(child: Container()),
          Text(
            '캠핑 감성',
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: Container()),
          SizedBox(width: 36),
        ],
      ),
    );
  }
}
