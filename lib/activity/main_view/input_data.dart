import 'package:carmoa/activity/main_view/car_info_view.dart';
import 'package:carmoa/config/assist_util.dart';
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
  bool isFront = false;
  bool isBack = false;

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Model>(context);
    final cycle = Provider.of<Cycle>(context);
    final db = CreateDB();
    final timeCheck = formatDate(DateTime.now(), [yyyy, '년', mm, '월', dd, '일']);

    return FutureBuilder(
      future: viewSize(Stream<Size>.periodic(
          Duration(milliseconds: 100), (x) => MediaQuery.of(context).size)),
      builder: (context, snap) {
        Size _size = snap.data;
        return Scaffold(
          backgroundColor: baseColor,
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: _size != null ? _size.height * 0.5 : 0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.orange, Colors.deepOrange]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 2)
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: _size != null ? (_size.height * 0.5) - 186 : 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: 186,
                      child: Image.asset(
                        'assets/images/car_input.png',
                        fit: BoxFit.cover,
                      ))),
              Positioned(
                top: _size != null ? _size.height * 0.05 : 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.only(top: 30),
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
                      // Divider(color: iconMenuColor),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: 0,
                left: 0,
                child: Container(
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          blurRadius: 2)
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.deepOrangeAccent),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('주행거리 : ',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black87)),
                                Flexible(
                                  child: Container(
                                    child: TextField(
                                      style: TextStyle(color: Colors.black87),
                                      onChanged: (String _value) {
                                        exchangeValue = int.parse(
                                            _value.replaceAll(',', ''));
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.end,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        ThousandsFormatter()
                                      ],
                                      maxLength: 11,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                          suffixText: ' km',
                                          suffixStyle:
                                              TextStyle(color: Colors.black87)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.deepOrangeAccent),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('교환비용 :',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black87)),
                                Flexible(
                                  child: Container(
                                    child: TextField(
                                      style: TextStyle(color: Colors.black87),
                                      onChanged: (String _value) {
                                        priceValue = int.parse(
                                            _value.replaceAll(',', ''));
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.end,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        ThousandsFormatter()
                                      ],
                                      maxLength: 11,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                          suffixText: ' 원',
                                          suffixStyle:
                                              TextStyle(color: Colors.black87)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 앞 / 뒤 교환 확인
                      exchangeCheck(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 390,
                left: _size != null ? (_size.width * 0.5) - 30 : 100,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        blurRadius: 1,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 400,
                left: _size != null ? (_size.width * 0.5) - 20 : 100,
                child: Builder(
                  builder: (context) => InkWell(
                    onTap: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                      if (exchangeValue == null || exchangeValue == 0) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(CupertinoIcons.exclamationmark_circle,
                                    size: 15),
                                SizedBox(width: 6),
                                Text('주행거리를 입력해 주세요',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        );
                      } else if (priceValue == null || priceValue == 0) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(CupertinoIcons.exclamationmark_circle,
                                    size: 15),
                                SizedBox(width: 6),
                                Text('교환비용을 입력해 주세요',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        );
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
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            colors: [Colors.orangeAccent, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 2)
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(CupertinoIcons.arrow_right_square,
                            color: Color.fromRGBO(217, 254, 207, 1)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Row exchangeCheck() {
    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text('앞 교환'),
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                  value: isFront,
                  onChanged: (value) {
                    setState(() {
                      isFront = value;
                    });
                  }),
            )
          ],
        ),
        Expanded(child: Container()),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text('뒤 교환'),
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                  value: isBack,
                  onChanged: (value) {
                    setState(() {
                      isBack = value;
                    });
                  }),
            )
          ],
        ),
      ],
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
