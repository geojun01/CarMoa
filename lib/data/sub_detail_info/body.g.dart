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
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'items': instance.items,
    };
