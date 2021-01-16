// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    contentid: json['contentid'] as int,
    originimgurl: json['originimgurl'] as String,
    serialnum: json['serialnum'] as String,
    smallimageurl: json['smallimageurl'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'contentid': instance.contentid,
      'originimgurl': instance.originimgurl,
      'serialnum': instance.serialnum,
      'smallimageurl': instance.smallimageurl,
    };
