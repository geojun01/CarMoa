import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoaHome extends StatefulWidget {
  final Function menuCallback;

  MoaHome({@required this.menuCallback});

  @override
  _MoaHomeState createState() => _MoaHomeState();
}

class _MoaHomeState extends State<MoaHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(menuOpen ? 40.0 : 0.9),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: widget.menuCallback,
                      child: Icon(menuOpen
                          ? FontAwesomeIcons.angleDoubleLeft
                          : FontAwesomeIcons.bars)),
                  Column(
                    children: [
                      Text('CarMoa', style: titleBoldFont),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Theme
                                .of(context)
                                .primaryColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text('Lyon, France', style: titleMinFont),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 22.0,
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                  )
                ],
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Color.fromRGBO(230, 235, 235, 1)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    // 상단 메뉴 리스트
                    Container(
                      height: 110.0,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 20.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: animalType.length,
                          itemBuilder: (context, index) {
                            return buildAnimalIcon(index);
                          }),
                    ),
                    // 세부 메뉴 화면
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: Card(
                          color: Colors.white,
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(children: [
                                  Icon(FontAwesomeIcons.car,
                                      color: Theme
                                          .of(context)
                                          .primaryColor
                                          .withOpacity(0.8)),
                                  SizedBox(width: 10),
                                  Text(
                                    '엔진오일',
                                    style: titleMain,
                                  )
                                ]),
                                Divider(
                                    height: 16,
                                    color: startColor,
                                    thickness: 1),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List 아이콘 목록
  Widget buildAnimalIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
                // print("선택 항목 " + animalType[index]);
              });
            },
            child: Material(
              color: selectedIndex == index
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.white,
              elevation: selectedIndex == index ? 8.0 : 1.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  animalIcons[index],
                  color: selectedIndex == index
                      ? Colors.white
                      : Theme
                      .of(context)
                      .primaryColor,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            animalType[index],
            style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
