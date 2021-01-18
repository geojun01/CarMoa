// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailInfoData _$DetailInfoDataFromJson(Map<String, dynamic> json) {
  return DetailInfoData(
    response: json['response'] == null
        ? null
        : Response.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailInfoDataToJson(DetailInfoData instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
