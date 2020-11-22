import 'package:flutter/material.dart';

class Car extends StatefulWidget {
  @override
  _CarState createState() => _CarState();
}

class _CarState extends State<Car> {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: SafeArea(
        child: ListView(
          children: [
            Text("Car"),
          ],
        ),
      ),
    );
  }
}
