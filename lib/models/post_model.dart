import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: 0)
  int hangxeid;

  @JsonKey(defaultValue: 0)
  int dongxeid;

  @JsonKey(defaultValue: '')
  String namsx;

  @JsonKey(defaultValue: '')
  String phienban;

  @JsonKey(defaultValue: '')
  String giaban;

  @JsonKey(defaultValue: '')
  String fileupload;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String mota;

  @JsonKey(defaultValue: '')
  String video;

  @JsonKey(defaultValue: '')
  String fullname;

  @JsonKey(defaultValue: '')
  String phone;

  @JsonKey(defaultValue: '')
  String address;

  @JsonKey(defaultValue: '')
  String location;

  PostModel({
    this.id = 0,
    this.hangxeid = 0,
    this.dongxeid = 0,
    this.namsx = '',
    this.phienban = '',
    this.giaban = '',
    this.fileupload = '',
    this.title = '',
    this.mota = '',
    this.video = '',
    this.fullname = '',
    this.phone = '',
    this.address = '',
    this.location = '',
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
