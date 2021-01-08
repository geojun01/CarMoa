import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Camping extends StatefulWidget {
  @override
  _CampingState createState() => _CampingState();
}

class _CampingState extends State<Camping> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isIconMenuCheck = false;
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: FutureBuilder<Size>(
              future: viewSize(Stream<Size>.periodic(Duration(milliseconds: 100),
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
                    Stack(
                      children: [
                        Image.network(
                            'https://raw.githubusercontent.com/geojun01/CarMoa/master/test.jpg'),
                        Positioned(
                            bottom: 10.0,
                            right: 10.0,
                            child: Text('Test Image',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.deepOrangeAccent)))
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: _size != null ? _size.width : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Test'),
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
