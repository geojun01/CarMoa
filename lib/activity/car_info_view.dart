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
  List<CarModel> _select;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.chart_bar_circle,
                ),
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
                  _select = null;
                  _select = snap.data;

                  if (itemView.getAllIndex() > 0) {
                    itemView.setClear();
                    _select.forEach(
                      (element) {
                        if (element != null) {
                          if (element.nameCode == titleName) {
                            itemView.selectItemAdd(element);
                          }
                        }
                      },
                    );
                  }

                  if (itemView.getIndex() > 0) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 9,
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
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text('교환거리', style: mainText14),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 6),
                                          Icon(CupertinoIcons.chevron_right,
                                              color: Colors.deepOrangeAccent,
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text(
                                              '${NumberFormat('###,###,###').format(itemView.getExchangeLast())} km',
                                              style: mainText14),
                                        ],
                                      ),
                                      Divider(color: startColor),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.arrow_left_square,
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text('다음교환', style: mainText14),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 6),
                                          Icon(CupertinoIcons.chevron_right,
                                              color: Colors.deepOrangeAccent,
                                              size: 14),
                                          SizedBox(width: 6),
                                          Text(
                                              '${NumberFormat('###,###,###').format(itemView.getExchangeLast() + exchangeTime)} km',
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
                              flex: 9,
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
                                                size: 14),
                                            SizedBox(width: 6),
                                            Text(
                                                '비용 : ${NumberFormat('###,###,###').format(itemView.getPrice())}원',
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
                                                color: Colors.deepOrangeAccent,
                                                size: 14),
                                            SizedBox(width: 6),
                                            Text(
                                                '${datePast(itemView.getDateLast())}',
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
                                              infoExchange: itemView
                                                          .getExchangeLast() !=
                                                      null
                                                  ? itemView.getExchangeLast()
                                                  : 0));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                          CupertinoIcons
                                              .rectangle_stack_badge_plus,
                                          size: 28),
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
                              infoExchange: 0,
                            ),
                          );
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
      _km = cycle.getWiper(); //와이퍼
      break;
    case 3:
      _km = cycle.getTire(); //타이어
      break;
    case 4:
      _km = cycle.getBreak(); //브레이크 패드
      break;
    case 5:
      _km = cycle.getBreakOil(); //브레이크 오일
      break;
    case 6:
      _km = cycle.getBattery(); //배터리
      break;
    case 7:
      _km = cycle.getPlug(); //점화플러그
      break;
    case 8:
      _km = cycle.getAntifreeze(); //부동액
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
  return Column(
    children: [
      Row(
        children: [
          Icon(CupertinoIcons.calendar, size: 14),
          SizedBox(width: 6),
          Text('교환날짜', style: mainText14),
        ],
      ),
      Row(
        children: [
          SizedBox(width: 6),
          Icon(CupertinoIcons.right_chevron,
              color: Colors.deepOrangeAccent, size: 14),
          SizedBox(width: 6),
          Text('${itemView.carData.length > 0 ? date[0] : ''}',
              style: mainText14),
        ],
      ),
    ],
  );
}
