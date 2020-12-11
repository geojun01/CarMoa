import 'package:carmoa/activity/car_info_view.dart';
import 'package:carmoa/activity/test.dart';
import 'package:carmoa/config/MyBehavior.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/model.dart';
import 'package:carmoa/config/selected_menu.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'file:///D:/Android-Files/carmoa/lib/widgets/fade_in_ainmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MoaHome extends StatefulWidget {
  final Function menuCallback;

  MoaHome({@required this.menuCallback});

  @override
  _MoaHomeState createState() => _MoaHomeState();
}
class _MoaHomeState extends State<MoaHome> {
  @override
  Widget build(BuildContext context) {
    final v = Provider.of<Model>(context);
    return Material(
      elevation: menuOpen ? 14 : 0,
      borderRadius: BorderRadius.circular(menuOpen ? 40.0 : 0.9),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
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
                          child: Icon(
                            menuOpen
                                ? FontAwesomeIcons.angleDoubleLeft
                                : FontAwesomeIcons.bars,
                            size: menuOpen ? 40 : 20,
                            color: mainColor,
                          )),
                      Column(
                        children: [
                          Text('CarMoa', style: titleBoldFont),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Theme.of(context).primaryColor,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text('Lyon, France', style: titleMinFont),
                            ],
                          ),
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomLeft: menuOpen
                              ? Radius.circular(40)
                              : Radius.circular(0)),
                      color: Color.fromRGBO(230, 235, 235, 0.7)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // 상단 메뉴 리스트
                      Container(
                        height: 110.0,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 20.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: modifyType.length,
                            itemBuilder: (context, index) {
                              return buildAnimalIcon(index);
                            }),
                      ),
                      // 세부 메뉴 화면
                      FadeIn(delay: 2, child: carInfoView(context)),
                      SizedBox(height: 11),
                      FlatButton(onPressed: (){
                        // 데이터 저장 버튼
                        saveData(v.getIndex());
                        v.itemAdd(new CarModel(
                            id: v.getIndex(),
                            dateTime: DateTime.now().toString(),
                            nameCode: '자료 ${v.getIndex().toString()}',
                            exchange: '교환 ${v.getIndex().toString()}',
                            price: 40000 + v.getIndex(),
                            front: '앞',
                            back: '뒤'));
                        //print ('Index : ${Model().getIndex()}');
                      }, child: Text('자료입력'),),
                      SizedBox(height: 10,),
                      FlatButton(onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Test()));
                      }, child: Text('화면이동'),),
                    ],
                  ),
                ),
              ],
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
                Provider.of<SelectMenu>(context, listen: false)
                    .setSelect(index);
                // print("선택메뉴 $selected");
              },
              child: Consumer<SelectMenu>(
                builder: (context, value, child) => Material(
                  color: Colors.white,
                  elevation: value.getSelect() == index ? 8.0 : 1.0,
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
