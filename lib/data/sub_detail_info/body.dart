import 'package:carmoa/data/sub_detail_info/items.dart';
import 'package:json_annotation/json_annotation.dart';

part 'body.g.dart';

@JsonSerializable()
class Body {
  final Items items;

  Body({this.items});

  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);

  Map<String, dynamic> toJson() => _$BodyToJson(this);
}