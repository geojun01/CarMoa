import 'package:carmoa/config/config_style.dart';
import 'package:carmoa/config/selected_menu.dart';
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
                Expanded(child: SizedBox(width: 16,)),
                Text(
                  '교환주기 : 8,000km',
                  textAlign: TextAlign.end,
                  style: mainFont,
                )
              ],
            ),
            Divider(height: 16, color: startColor, thickness: 1),
          ],
        ),
      ),
    ),
  );
}
