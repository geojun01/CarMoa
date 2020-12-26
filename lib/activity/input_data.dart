import 'package:carmoa/config/assist_util.dart';
import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/provider/model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputData extends StatefulWidget {
  final titleName;

  InputData({Key key, @required this.titleName}): super(key: key);

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
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        elevation: 4,
        title: Text('${widget.titleName}',style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('교환날짜 : ${timeCheck[0]}'),
                Expanded(child: Container()),
                changeTime()
              ],
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
    for(int i=0; i < modifyType.length; i++) {
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
    loadPreferenceInt(saveTitle: widget.titleName, initValue: value, context: context);
    return Text('교환주기 : ${item.getCycle() != null ? item.getCycle() : 0}');
  }
}
