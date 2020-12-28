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

String value;
bool isCheck = true;

class _InputDataState extends State<InputData> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Model>(context);
    final cycle = Provider.of<Cycle>(context);
    final db = CreateDB();
    final timeCheck = formatDate(DateTime.now(), [yyyy, '년', mm, '월', dd, '일']);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
        title: Text(
          '${widget.titleName}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
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
                        style: TextStyle(fontSize: 16),
                      ),
                      Divider(color: startColor),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onChanged: (String _value) {
                            value = _value;
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter()
                          ],
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: '주행거리',
                            labelStyle: TextStyle(
                                fontSize: 16, color: Colors.deepOrangeAccent),
                            counterText: '',
                            suffixText: ' km',
                            // suffixIcon: Icon(CupertinoIcons.folder_badge_plus),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter()
                          ],
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: '교환비용',
                            labelStyle: TextStyle(
                                fontSize: 16, color: Colors.deepOrangeAccent),
                            counterText: '',
                            suffixText: ' 원',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 100,
              child: RaisedButton(
                  color: Colors.orange,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.folder_badge_plus,
                          color: Colors.white),
                      SizedBox(width: 6),
                      Text('저장', style: TextStyle(color: Colors.white))
                    ],
                  )),
            )
          ],
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
      style: TextStyle(fontSize: 16),
    );
  }
}
