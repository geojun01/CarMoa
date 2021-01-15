// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    addr1: json['addr1'] as String,
    areacode: json['areacode'] as int,
    cat1: json['cat1'] as String,
    cat2: json['cat2'] as String,
    cat3: json['cat3'] as String,
    contentid: json['contentid'] as int,
    contenttypeid: json['contenttypeid'] as int,
    createdtime: json['createdtime'] as int,
    firstimage: json['firstimage'] as String,
    firstimage2: json['firstimage2'] as String,
    mapx: json['mapx'],
    mapy: json['mapy'],
    mlevel: json['mlevel'] as int,
    modifiedtime: json['modifiedtime'] as int,
    readcount: json['readcount'] as int,
    sigungucode: json['sigungucode'] as int,
    tel: json['tel'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'addr1': instance.addr1,
      'areacode': instance.areacode,
      'cat1': instance.cat1,
      'cat2': instance.cat2,
      'cat3': instance.cat3,
      'contentid': instance.contentid,
      'contenttypeid': instance.contenttypeid,
      'createdtime': instance.createdtime,
      'firstimage': instance.firstimage,
      'firstimage2': instance.firstimage2,
      'mapx': instance.mapx,
      'mapy': instance.mapy,
      'mlevel': instance.mlevel,
      'modifiedtime': instance.modifiedtime,
      'readcount': instance.readcount,
      'sigungucode': instance.sigungucode,
      'tel': instance.tel,
      'title': instance.title,
    };
