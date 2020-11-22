import 'package:flutter/material.dart';

class CarModel {
  final String id;
  final String dateTime;
  final String nameCode;
  final String exchange;
  final int price;
  final String front;
  final String back;

  CarModel({this.id, this.dateTime, this.nameCode, this.exchange, this.price,
      this.front, this.back});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'nameCode' : nameCode,
      'exchange' : exchange,
      'price' : price,
      'front' : front,
      'back' : back
    };
  }

  @override
  String toString() {
    return 'CarModel{id: $id, dateTime: $dateTime, nameCode: $nameCode, exchange: $exchange, price: $price, front: $front, back: $back}';
  }
}
