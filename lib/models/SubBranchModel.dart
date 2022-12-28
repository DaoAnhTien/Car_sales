import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'SubBranchModel.g.dart';

@JsonSerializable(explicitToJson: true)
class SubBranchModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String url;

  @JsonKey(defaultValue: '')
  String slug;

  @JsonKey(defaultValue: '')
  String icon;

  @JsonKey(defaultValue: 0)
  int parentId;

  @JsonKey(defaultValue: 0)
  int position;

  @JsonKey(defaultValue: '')
  String createdAt;

  @JsonKey(defaultValue: '')
  String updatedAt;

  SubBranchModel(
      {this.id = 0,
      this.name = '',
      this.url = '',
      this.slug = '',
      this.icon = '',
      this.parentId = 0,
      this.position = 0,
      this.createdAt = '',
      this.updatedAt = ''});

  factory SubBranchModel.fromJson(Map<String, dynamic> json) =>
      _$SubBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubBranchModelToJson(this);
}
