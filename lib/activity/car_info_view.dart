import 'dart:math';

import 'package:carmoa/activity/input_data.dart';
import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/config/provider/selected_menu.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

var titleName;
var indexCycleMenu;
int exchangeTime;

Widget carInfoView(BuildContext context) {
  final itemView = Provider.of<Model>(context);
  final db = CreateDB();

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.car,
                    color: Theme.of(context).primaryColor.withOpacity(0.8)),
                SizedBox(width: 10),
                Consumer<SelectMenu>(
                  builder: (context, value, child) {
                    indexCycleMenu = value.getSelect();
                    return titleText(value);
                  },
                ),
                Expanded(child: SizedBox(width: 16)),
                changeCycle(context)
              ],
            ),
            Divider(height: 16, color: startColor, thickness: 0.5),
            // 정보창 세부 내용 표시
            FutureBuilder(
              future: db.loadData(),
              builder: (context, snap) {
                if (snap.hasData) {
                  itemView.listAdd(snap.data);
                  final List<CarModel> _item = snap.data;
                  if (_item.length > 0) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      lastDate(context, itemView),
                                      Divider(color: startColor),
                                      Row(
                                        children: [
                                          Icon(
                                              CupertinoIcons
                                                  .arrow_left_right_square,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text('교환거리', style: mainText14),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.chevron_right,
                                              size: 14,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          SizedBox(width: 6),
                                          Text(
                                              '${_item.length > 0 ? NumberFormat('###,###,###').format(_item.last.exchange) : ''} km',
                                              style: mainText14),
                                        ],
                                      ),
                                      Divider(color: startColor),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.arrow_left_square,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text('다음교환', style: mainText14),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.chevron_right,
                                              size: 14,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          SizedBox(width: 6),
                                          Text(
                                              '${itemView.carData.length > 0 ? NumberFormat('###,###,###').format(itemView.getExchangeLast() + exchangeTime) : ''} km',
                                              style: mainText14),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                                CupertinoIcons
                                                    .money_dollar_circle,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 14),
                                            SizedBox(width: 6),
                                            Text(
                                                '비용 : ${_item.length > 0 ? NumberFormat('###,###,###').format(_item.last.price) : ''}원',
                                                style: mainText14),
                                          ],
                                        ),
                                        Divider(color: startColor),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(CupertinoIcons.calendar,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 14),
                                            SizedBox(width: 6),
                                            Text('사용기간', style: mainText14),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(CupertinoIcons.chevron_right,
                                                size: 14,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            SizedBox(width: 6),
                                            Text(
                                                '${_item.length > 0 ? datePast(_item.last.dateTime) : ''}',
                                                style: mainText14),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // 자료입력 아이콘
                                  InkWell(
                                    onTap: () {
                                      aniNavigator(
                                          context,
                                          InputData(
                                              titleName: titleName,
                                              cycleIndex: indexCycleMenu));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                          CupertinoIcons
                                              .rectangle_stack_badge_plus,
                                          size: 28,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }
                return Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.exclamationmark_circle,
                              size: 16,
                              color: Color.fromRGBO(150, 150, 150, 1)),
                          SizedBox(width: 6),
                          Text('저장된 Data가 없습니다.',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(150, 150, 150, 1))),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          aniNavigator(
                              context,
                              InputData(
                                  titleName: titleName,
                                  cycleIndex: indexCycleMenu));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(CupertinoIcons.rectangle_stack_badge_plus,
                              size: 28, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Text changeCycle(BuildContext context) {
  final selectPick = Provider.of<SelectMenu>(context);
  final cycle = Provider.of<Cycle>(context);
  int _km;

  switch (selectPick.getSelect()) {
    case 0:
      _km = cycle.getEng(); //엔진오일
      break;
    case 1:
      _km = cycle.getAir(); //에어크리너
      break;
    case 2:
      _km = cycle.getTire(); //타이어
      break;
    case 3:
      _km = cycle.getBreak(); //브레이크패드
      break;
    case 4:
      _km = cycle.getBreakOil(); //브레이크오일
      break;
  }

  exchangeTime = _km;

  return Text(
    '교환주기 : ${_km != null ? NumberFormat('###,###,###').format(_km) : 0} km',
    textAlign: TextAlign.end,
    style: mainText14,
  );
}

Text titleText(SelectMenu value) {
  titleName = modifyType[value.getSelect()];
  return Text(
    modifyType[value.getSelect()],
    textAlign: TextAlign.start,
    style: titleMain15,
  );
}

Widget lastDate(BuildContext context, Model itemView) {
  var date;
  if (itemView.carData.length > 0) {
    String item = itemView.getDateLast();
    date = item.split(' ');
  }
  return Row(
    children: [
      Icon(CupertinoIcons.calendar,
          color: Theme.of(context).primaryColor, size: 14),
      SizedBox(width: 6),
      Text('교환날짜 : ${itemView.carData.length > 0 ? date[0] : ''}',
          style: mainText14),
    ],
  );
}
