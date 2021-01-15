import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part 'items.g.dart';

@JsonSerializable()
class Items {
  final List<Item> item;

  Items({this.item});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}