import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'version_model.g.dart';
@JsonSerializable(explicitToJson: true)
class VersionModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String name;

  VersionModel({this.id = '', this.name = ''});

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
