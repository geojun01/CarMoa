// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_image_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubImageData _$SubImageDataFromJson(Map<String, dynamic> json) {
  return SubImageData(
    response: json['response'] == null
        ? null
        : Response.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubImageDataToJson(SubImageData instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
