import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'my_post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MyPostModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String image;

  @JsonKey(defaultValue: 0)
  int stt;

  @JsonKey(defaultValue: 0)
  int uptime;

  MyPostModel(
      {this.id = 0,
      this.title = '',
      this.image = '',
      this.stt = 0,
      this.uptime = 0});

  factory MyPostModel.fromJson(Map<String, dynamic> json) =>
      _$MyPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyPostModelToJson(this);
}
