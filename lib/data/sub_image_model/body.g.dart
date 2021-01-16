// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    items: json['items'] == null
        ? null
        : Items.fromJson(json['items'] as Map<String, dynamic>),
    numOfRows: json['numOfRows'] as int,
    pageNo: json['pageNo'] as int,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'items': instance.items,
      'numOfRows': instance.numOfRows,
      'pageNo': instance.pageNo,
      'totalCount': instance.totalCount,
    };
