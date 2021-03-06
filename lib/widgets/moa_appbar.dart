import 'package:carmoa/config/config_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoaAppBar extends StatelessWidget {
  final title;

  MoaAppBar({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isIconMenuCheck = false;
        return true;
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(42, 139, 229, 1),
              Color.fromRGBO(25, 103, 182, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    isIconMenuCheck = false;
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(CupertinoIcons.left_chevron,
                        size: 26, color: baseColor),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                '$title',
                style: TextStyle(
                    fontSize: 20, color: baseColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
