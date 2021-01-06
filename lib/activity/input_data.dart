import 'package:carmoa/activity/car_info_view.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

class InputData extends StatefulWidget {
  final titleName;
  final infoExchange;

  InputData({Key key, @required this.titleName, @required this.infoExchange})
      : super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  int exchangeValue = 0;
  int priceValue = 0;
  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Model>(context);
    final cycle = Provider.of<Cycle>(context);
    final db = CreateDB();
    final timeCheck = formatDate(DateTime.now(), [yyyy, '년', mm, '월', dd, '일']);

    return Scaffold(
      // resizeToAvoidBottomPadding ->  키보드가 올라와도 화면을 밀어올리는걸 방지 한다
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(80, 174, 146, 1),
                Color.fromRGBO(12, 147, 106, 1)
              ]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                CupertinoIcons.left_chevron,
                                color: whiteColor,
                                size: 24,
                              ),
                            )),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${widget.titleName}',
                      style: TextStyle(
                          fontSize: 18,
                          color: whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(child: Container()),
                    Container(width: 50),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Divider(color: iconMenuColor),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Text(
                                '교환날짜 : $timeCheck',
                                style: titleText16,
                              ),
                              Divider(
                                color: Color.fromRGBO(217, 254, 207, 1),
                                thickness: 0.5,
                              ),
                              cycleMenu(cycle, widget.titleName),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 4,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(6.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('주행거리 : ',
                                            style: TextStyle(
                                                fontSize: 16)),
                                        Flexible(
                                          child: Container(
                                            child: TextField(
                                              onChanged: (String _value) {
                                                exchangeValue = int.parse(
                                                    _value.replaceAll(',', ''));
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.end,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                ThousandsFormatter()
                                              ],
                                              maxLength: 11,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                counterText: '',
                                                suffixText: ' km',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      borderRadius: BorderRadius.circular(6.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('교환비용 :',
                                            style: TextStyle(
                                                fontSize: 16)),
                                        Flexible(
                                          child: Container(
                                            child: TextField(
                                              onChanged: (String _value) {
                                                priceValue = int.parse(
                                                    _value.replaceAll(',', ''));
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.end,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                ThousandsFormatter()
                                              ],
                                              maxLength: 11,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                counterText: '',
                                                suffixText: ' 원',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 120,
                      child: Builder(
                        builder: (context) => RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            Scaffold.of(context).hideCurrentSnackBar();
                            if (exchangeValue == null || exchangeValue == 0) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Row(
                                children: [
                                  Icon(CupertinoIcons.exclamationmark_circle,
                                      size: 15),
                                  SizedBox(width: 6),
                                  Text('주행거리를 입력해 주세요',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              )));
                            } else if (priceValue == null || priceValue == 0) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Row(
                                children: [
                                  Icon(CupertinoIcons.exclamationmark_circle,
                                      size: 15),
                                  SizedBox(width: 6),
                                  Text('교환비용을 입력해 주세요',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              )));
                            } else if (exchangeValue <= widget.infoExchange) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '기존 주행거리 ${widget.infoExchange}km 보다 작거나 같습니다.')));
                            } else {
                              // 데이터베이스 저장 코드
                              // print('확인 : $exchangeValue : $priceValue');
                              var saveItem = new CarModel(
                                  id: DateTime.now().toString(),
                                  dateTime: DateTime.now().toString(),
                                  nameCode: titleName,
                                  exchange: exchangeValue,
                                  price: priceValue,
                                  period: 'no',
                                  front: 'no',
                                  back: 'no');
                              db.saveData(saveItem);
                              item.itemAdd(saveItem);
                              Future.delayed(
                                Duration(milliseconds: 200),
                                () => {
                                  exchangeValue = 0,
                                  priceValue = 0,
                                  Navigator.pop(context),
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.folder_badge_plus,
                                  color: Colors.white),
                              SizedBox(width: 10),
                              Text('저장', style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text cycleMenu(Cycle cycle, String _name) {
    int cycleValue;

    switch (_name) {
      case '엔진오일':
        cycleValue = cycle.getEng(); //엔진오일
        break;
      case '에어크리너':
        cycleValue = cycle.getAir(); //에어크리너
        break;
      case '와이퍼':
        cycleValue = cycle.getWiper(); //와이퍼
        break;
      case '타이어':
        cycleValue = cycle.getTire(); //타이어
        break;
      case '브레이크패드':
        cycleValue = cycle.getBreak(); //브레이크패드
        break;
      case '브레이크오일':
        cycleValue = cycle.getBreakOil(); //브레이크오일
        break;
      case '배터리':
        cycleValue = cycle.getBattery(); //배터리
        break;
      case '점화플러그':
        cycleValue = cycle.getPlug(); //점화플러그
        break;
      case '부동액':
        cycleValue = cycle.getAntifreeze(); //점화플러그
        break;
    }
    return Text(
      '교환주기 : ${NumberFormat('###,###,###').format(cycleValue)} km',
      style: titleText16,
    );
  }
}
