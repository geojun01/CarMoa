import 'package:flutter/cupertino.dart';

class CarModel {
  final String id;
  final String dateTime;
  final String nameCode;
  final int exchange;
  final int price;
  final String period;
  final String front;
  final String back;

  CarModel(
      {@required this.id,
      @required this.dateTime,
      @required this.nameCode,
      @required this.exchange,
      @required this.price,
      @required this.period,
      @required this.front,
      @required this.back});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime,
      'nameCode': nameCode,
      'exchange': exchange,
      'price': price,
      'period': period,
      'front': front,
      'back': back
    };
  }

  @override
  String toString() {
    return 'CarModel{id: $id, dateTime: $dateTime, nameCode: $nameCode, exchange: $exchange, price: $price, period: $period, front: $front, back: $back}';
  }
}
