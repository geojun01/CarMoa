import 'package:carmoa/config/config_style.dart';
import 'package:flutter/material.dart';

class Car extends StatefulWidget {
  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0.0)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen
                            ? IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                })
                            : IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  setState(() {
                                    // xOffset = MediaQuery.of(context).size.width / 230;
                                    // yOffset = MediaQuery.of(context).size.height / 150;
                                    xOffset = 230;
                                    yOffset = 120;
                                    scaleFactor = 0.7;
                                    isDrawerOpen = true;
                                  });
                                }),
                        Column(
                          children: [Text('CarMoa')],
                        ),
                        SizedBox(width: 20, height: 10)
                      ],
                    ),
                    Text("본문 내용 표시 구간", style: mainFont),
                    SizedBox(height: 100)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
