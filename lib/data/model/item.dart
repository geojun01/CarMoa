import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String addr1;
  final int areacode;
  final String cat1;
  final String cat2;
  final String cat3;
  final int contentid;
  final int contenttypeid;
  final int createdtime;
  final String firstimage;
  final String firstimage2;
  var mapx;
  var mapy;
  final int mlevel;
  final int modifiedtime;
  final int readcount;
  final int sigungucode;
  final String tel;
  final String title;

  Item(
      {this.addr1,
        this.areacode,
        this.cat1,
        this.cat2,
        this.cat3,
        this.contentid,
        this.contenttypeid,
        this.createdtime,
        this.firstimage,
        this.firstimage2,
        this.mapx,
        this.mapy,
        this.mlevel,
        this.modifiedtime,
        this.readcount,
        this.sigungucode,
        this.tel,
        this.title});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}