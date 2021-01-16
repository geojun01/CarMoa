import 'package:carmoa/data/sub_image_model/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_image_data.g.dart';

@JsonSerializable()
class SubImageData {
  final Response response;

  SubImageData({this.response});

  factory SubImageData.fromJson(Map<String, dynamic> json) => _$SubImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$SubImageDataToJson(this);
}