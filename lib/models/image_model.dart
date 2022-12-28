import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(explicitToJson: true)
class ImageModel extends HiveObject {
  @HiveField(0, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  double width;

  @HiveField(1, defaultValue: 0)
  @JsonKey(defaultValue: 0)
  double height;

  @HiveField(2, defaultValue: '')
  @JsonKey(defaultValue: '')
  String url;

  @HiveField(3, defaultValue: '')
  @JsonKey(defaultValue: '')
  String blurHash;

  ImageModel({
    this.width = 0,
    this.height = 0,
    this.url = '',
    this.blurHash = '',
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
