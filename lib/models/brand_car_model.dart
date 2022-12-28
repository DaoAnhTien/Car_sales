import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'brand_car_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BrandCarModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String alias;

  BrandCarModel({
    this.id = 0,
    this.title = '',
    this.alias = '',
  });

  factory BrandCarModel.fromJson(Map<String, dynamic> json) =>
      _$BrandCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandCarModelToJson(this);
}
