import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container carInfoView(BuildContext context, int selectedIndex) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.car,
                        color: Theme.of(context).primaryColor.withOpacity(0.8)),
                    SizedBox(width: 10),
                    Text(
                      modifyType[selectedIndex],
                      textAlign: TextAlign.start,
                      style: titleMain,
                    ),
                  ],
                ),
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