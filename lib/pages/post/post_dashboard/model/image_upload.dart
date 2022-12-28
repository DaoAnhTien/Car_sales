import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'image_upload.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageUploadModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String file;

  @JsonKey(defaultValue: '')
  String name;

  ImageUploadModel({this.file = '', this.name = ''});

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUploadModelToJson(this);
}
