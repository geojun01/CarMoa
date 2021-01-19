import 'package:carmoa/activity/camping/national_park.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/widgets/moa_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Camping extends StatefulWidget {
  @override
  _CampingState createState() => _CampingState();
}

class _CampingState extends State<Camping> {
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
                SizedBox(height: 8),
                FlatButton(
                    onPressed: () {
                      aniNavigator(context, NationalPark());
                    },
                    child: Text('국립공원')),
                ClipPath(
                  clipper: TriangleClip(),
                  child: Image.asset('assets/images/logo.jpg'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TriangleClip extends CustomClipper<Path> {
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(10, 0);
    path.lineTo(0, 10);
    path.close();
    return path;
  }

  bool shouldReclip(TriangleClip oldClipper) => false;
}