import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

class InputData extends StatefulWidget {
  final titleName;

  InputData({Key key, @required this.titleName}) : super(key: key);

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Model>(context);
    final db = CreateDB();
    var nowDate = DateTime.now().toString();
    var timeCheck = nowDate.split(' ');

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
            SizedBox(height: 6),
            Text('교환날짜 : ${timeCheck[0]}'),
            changeTime(),
            SizedBox(height: 6),
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

  Text changeTime() {
    final item = Provider.of<Model>(context);
    int index;
    int value;
    for (int i = 0; i < modifyType.length; i++) {
      if (modifyType[i] == widget.titleName) {
        index = i;
        break;
      }
    }

    switch (index) {
      case 0:
        value = 6000; //엔진오일
        break;
      case 1:
        value = 6000; //에어크리너
        break;
      case 2:
        value = 60000; //타이어
        break;
      case 3:
        value = 70000; //브레이크패드
        break;
      case 4:
        value = 80000; //브레이크오일
        break;
    }
    loadPreferenceInt(
        saveTitle: widget.titleName, initValue: value, context: context);
    return Text('교환주기 : ${item.getCycle() != null ? item.getCycle() : 0}');
  }
}
