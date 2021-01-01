import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/cycle_provider.dart';
import 'package:carmoa/config/provider/model.dart';
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
  final cycleIndex;

  InputData({Key key, @required this.titleName, @required this.cycleIndex})
      : super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

// int exchangeValue = 0;
// int priceValue = 0;
// bool isCheck = true;

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
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.green, Colors.teal],
          ),
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
                      padding: const EdgeInsets.only(left: 20),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              CupertinoIcons.chevron_left_2,
                              color: Color.fromRGBO(239, 247, 255, 1),
                              size: 24,
                            )),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${widget.titleName}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(239, 247, 255, 1),
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(child: Container()),
                    Container(width: 40),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
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
                              cycleMenu(cycle, widget.cycleIndex),
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                                fontSize: 16,
                                                color: graycolor)),
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
                                                fontSize: 16,
                                                color: graycolor)),
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

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 20),
                              //   child: TextField(
                              //     onChanged: (String _value) {
                              //       value = _value;
                              //     },
                              //     keyboardType: TextInputType.number,
                              //     textAlign: TextAlign.end,
                              //     inputFormatters: [
                              //       FilteringTextInputFormatter.digitsOnly,
                              //       ThousandsFormatter()
                              //     ],
                              //     maxLength: 10,
                              //     decoration: InputDecoration(
                              //       labelText: '주행거리',
                              //       labelStyle: TextStyle(
                              //           fontSize: 16,
                              //           color: Colors.deepOrangeAccent),
                              //       counterText: '',
                              //       suffixText: ' km',
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 100,
                      child: Builder(
                        builder: (context) => RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            Scaffold.of(context).hideCurrentSnackBar();
                            if (exchangeValue == null || exchangeValue == 0) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('주행거리의 값을 입력해 주세요')));
                            } else if (priceValue == null || priceValue == 0) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('교환비용 값을 입력해 주세요')));
                            } else {
                              // 데이터베이스 저장 코드
                              // print('확인 : $exchangeValue : $priceValue');

                              exchangeValue = 0;
                              priceValue = 0;
                              Navigator.pop(context);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.folder_badge_plus,
                                  color: Colors.white),
                              SizedBox(width: 6),
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

  Text cycleMenu(Cycle cycle, int _index) {
    int cycleValue;

    switch (_index) {
      case 0:
        cycleValue = cycle.getEng(); //엔진오일
        break;
      case 1:
        cycleValue = cycle.getAir(); //에어크리너
        break;
      case 2:
        cycleValue = cycle.getTire(); //타이어
        break;
      case 3:
        cycleValue = cycle.getBreak(); //브레이크패드
        break;
      case 4:
        cycleValue = cycle.getBreakOil(); //브레이크오일
        break;
    }
    return Text(
      '교환주기 : ${NumberFormat('###,###,###').format(cycleValue)} km',
      style: titleText16,
    );
  }
}
