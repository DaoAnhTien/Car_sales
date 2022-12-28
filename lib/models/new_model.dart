import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/models/blog_model.dart';

part 'new_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NewModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int total_size;

  @JsonKey(defaultValue: 0)
  int limit;

  @JsonKey(defaultValue: 0)
  int offset;

  @JsonKey(defaultValue: [])
  final List<BlogModel> blogs;

  NewModel(
      {this.total_size = 0,
      this.limit = 0,
      this.offset = 0, required this.blogs});

  factory NewModel.fromJson(Map<String, dynamic> json) =>
      _$NewModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewModelToJson(this);
}
