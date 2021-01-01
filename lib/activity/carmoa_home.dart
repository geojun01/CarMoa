import 'package:carmoa/activity/car_icon_menu.dart';
import 'package:carmoa/activity/car_info_view.dart';
import 'package:carmoa/activity/weather.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/my_behavior.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/config/provider/selected_menu.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:carmoa/main_screen/drawerScreen.dart';
import 'package:carmoa/widgets/fade_in_ainmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MoaHome extends StatefulWidget {
  @override
  _MoaHomeState createState() => _MoaHomeState();
}

class _MoaHomeState extends State<MoaHome> {
  final db = CreateDB();

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: menuOpen ? 14 : 0,
      borderRadius: BorderRadius.circular(menuOpen ? 40.0 : 0.9),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // AppBar 디자인
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                transitionsBuilder:
                                    (context, animation, animationTime, child) {
                                  return ScaleTransition(
                                    alignment: Alignment.topLeft,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (context, animation, animationTime) {
                                  return DrawerScreen();
                                },
                              ),
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.bars,
                            size: 20,
                            color: mainColor,
                          ),
                        ),
                        Column(
                          children: [
                            Text('CarMOA', style: titleBoldText18),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.commentDots,
                                  color: Color.fromRGBO(150, 150, 150, 1),
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text('자동차의 이것저것 모아 모아', style: titleMinText12),
                              ],
                            ),
                          ],
                        ),
                        Hero(
                          tag: 'logoImage',
                          child: CircleAvatar(
                            radius: 22.0,
                            backgroundImage: AssetImage('assets/images/logo.jpg'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  // Main Body 디자인
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            bottomLeft: menuOpen
                                ? Radius.circular(40)
                                : Radius.circular(0)),
                        // color: Color(0xFFF4EFF6)),
                        color: Color.fromRGBO(235, 235, 235, 1)),
                    // 실제 디자인 위젯 모음
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        // 날씨 메뉴
                        buildTopWeather(context),
                        SizedBox(height: 30),
                        // 상단 메뉴 리스트
                        Container(
                          height: 100.0,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 16.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: modifyType.length,
                              itemBuilder: (context, index) {
                                return buildAnimalIcon(index);
                              }),
                        ),
                        // 세부 메뉴 화면
                        FadeIn(delay: 2, child: carInfoView(context)),
                        SizedBox(height: 16),
                        // 하단 애니메이션 메뉴
                        CarIconMenu(),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('다음 메뉴'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // List 아이콘 목록
  Widget buildAnimalIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: FadeIn(
        delay: 2,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (!menuOpen) {
                  Provider.of<SelectMenu>(context, listen: false)
                      .setSelect(index);
                }
              },
              child: Consumer<SelectMenu>(
                builder: (context, value, child) => Material(
                  color: Colors.white,
                  elevation: value.getSelect() == index ? 6.0 : 1.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      animalIcons[index],
                      color: value.getSelect() == index
                          ? Colors.orangeAccent
                          : Theme.of(context).primaryColor,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Consumer<SelectMenu>(
              builder: (context, value, child) => Text(
                modifyType[index],
                style: TextStyle(
                  color: value.getSelect() == index
                      ? Colors.deepPurpleAccent
                      : Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: value.getSelect() == index
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
