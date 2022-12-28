import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'banner_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class BannerModel extends HiveObject {
  @HiveField(0, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  int id;

  @HiveField(1, defaultValue: '')
  @JsonKey(defaultValue: '')
  String photo;

  @HiveField(2, defaultValue: '')
  @JsonKey(defaultValue: '')
  String banner_type;

  @HiveField(3, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  int published;

  @HiveField(4, defaultValue: '')
  @JsonKey(defaultValue: '')
  String url;

  BannerModel(
      {this.id = 0,
      this.photo = '',
      this.banner_type = '',
      this.published = 0,
      this.url = ''});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
