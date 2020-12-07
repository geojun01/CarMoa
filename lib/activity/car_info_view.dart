import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/selected_menu.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Container carInfoView(BuildContext context) {

  return Container(
    margin: EdgeInsets.all(16.0),
    child: Card(
      color: Colors.white,
      elevation: 6,
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
                  builder: (context, value, child) => Text(
                    modifyType[value.getSelect()],
                    textAlign: TextAlign.start,
                    style: titleMain,
                  ),
                ),
                Expanded(child: SizedBox(width: 16)),
                Text(
                  '교환주기 : 8,000km',
                  textAlign: TextAlign.end,
                  style: mainFont,
                )
              ],
            ),
            Divider(height: 16, color: startColor, thickness: 1),
            // 정보창 세부 내용 표시
            FutureBuilder(
              future: loadData(),
              builder: (context, snap) {
                CarModel item = snap.data;
                if (!snap.hasData) {
                  return Container();
                } else if (snap.hasData) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text('${item.nameCode}', style: titleMain),
                          Expanded(child: SizedBox(width: 10)),
                          Text('주행거리 : ${item.exchange}', style: mainFont)
                        ],
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Future<CarModel> loadData() async{
  DBHelper db = DBHelper();
  var item = await db.loadData();
  return item.last;
}

Future<CarModel> saveData(int index) async {
  DBHelper db = DBHelper();
  var item = await db.insertData(new CarModel(
      id: index,
      dateTime: DateTime.now().toString(),
      nameCode: '자료 ${index.toString()}',
      exchange: '교환 ${index.toString()}',
      price: 40000 + index,
      front: '앞',
      back: '뒤'));
  print(item.toString());
  return item;
}
