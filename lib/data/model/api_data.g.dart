// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiData _$ApiDataFromJson(Map<String, dynamic> json) {
  return ApiData(
    response: json['response'] == null
        ? null
        : Response.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ApiDataToJson(ApiData instance) => <String, dynamic>{
      'response': instance.response,
    };
