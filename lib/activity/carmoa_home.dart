import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoaHome extends StatefulWidget {
  @override
  _MoaHomeState createState() => _MoaHomeState();
}

class _MoaHomeState extends State<MoaHome> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(FontAwesomeIcons.bars, size: 20),
                  Column(
                    children: [
                      Text('CarMoa', style: titleBoldFont),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.mapMarkerAlt, color: Theme.of(context).primaryColor, size: 14,),
                          SizedBox(width: 4),
                          Text('Lyon, France', style: titleMinFont),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 22.0,
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor.withOpacity(0.06)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
