import 'package:json_annotation/json_annotation.dart';

import 'body.dart';

part 'response.g.dart';

@JsonSerializable()
class Response {
  final Body body;

  Response({this.header, this.body});

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}