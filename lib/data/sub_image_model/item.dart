import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final int contentid;
  final String originimgurl;
  final String serialnum;
  final String smallimageurl;

  Item({this.contentid, this.originimgurl, this.serialnum, this.smallimageurl});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
