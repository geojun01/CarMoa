import 'package:carmoa/data/sub_detail_info/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_info.g.dart';

@JsonSerializable()
class DetailInfoData {
  final Response response;

  DetailInfoData({this.response});

  factory DetailInfoData.fromJson(Map<String, dynamic> json) => _$DetailInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailInfoDataToJson(this);
}