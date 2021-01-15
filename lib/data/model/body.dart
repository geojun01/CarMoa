import 'package:json_annotation/json_annotation.dart';

import 'items.dart';

part 'body.g.dart';

@JsonSerializable()
class Body {
  final Items items;
  final int numOfRows;
  final int pageNo;
  final int totalCount;

  Body({this.items, this.numOfRows, this.pageNo, this.totalCount});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);

  Map<String, dynamic> toJson() => _$BodyToJson(this);
}