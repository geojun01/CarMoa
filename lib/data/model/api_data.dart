import 'package:json_annotation/json_annotation.dart';

import 'response.dart';

part 'api.g.dart';

@JsonSerializable()
class ApiData {
  final Response response;

  ApiData({this.response});

  factory ApiData.fromJson(Map<String, dynamic> json) => _$ApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApiDataToJson(this);
}