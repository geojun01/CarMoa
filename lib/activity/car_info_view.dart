import 'package:carmoa/config/config_style.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/model.dart';
import 'file:///D:/Android-Files/carmoa/lib/config/provider/selected_menu.dart';
import 'package:carmoa/data/car_data_model.dart';
import 'package:carmoa/data/db_create.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Container carInfoView(BuildContext context) {
  final itemView = Provider.of<Model>(context);
  final db = CreateDB();

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
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
            Divider(height: 16, color: startColor, thickness: 0.5),
            // 정보창 세부 내용 표시
            FutureBuilder(
              future: db.loadData(),
              builder: (context, snap) {
                itemView.listAdd(snap.data);
                final List<CarModel> _item = snap.data;

                if (!snap.hasData) {
                  return Container();
                } else if (snap.hasData) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              '${itemView.carData.length > 0 ? _item.last.nameCode : '-'}',
                              style: mainFont),
                          Expanded(child: SizedBox(width: 10)),
                          Text(
                              '주행거리 : ${itemView.carData.length > 0 ? itemView.getCodeLast() : '-'}',
                              style: mainFont)
                        ],
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Text(
                'A-Name : ${itemView.getIndex() > 0 ? itemView.getNameLast() : '-'}'),
            Text(
                'cc-Name : ${itemView.getIndex() > 0 ? itemView.getIdLast() : '-'}'),
          ],
        ),
      ),
    ),
  );
}
