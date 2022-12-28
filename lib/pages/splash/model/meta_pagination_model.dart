import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';


part 'meta_pagination_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MetaPaginationModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int limit;

  @JsonKey(defaultValue: 0)
  int offset;

  @JsonKey(defaultValue: 0)
  int total;

  @JsonKey(defaultValue: 0)
  int totalPages;

  MetaPaginationModel({
    this.limit = 0,
    this.offset = 0,
    this.total = 0,
    this.totalPages = 0,
  });

  factory MetaPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$MetaPaginationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetaPaginationModelToJson(this);
}
