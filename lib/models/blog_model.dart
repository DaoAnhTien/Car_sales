import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'blog_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BlogModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: '')
  String url;

  @JsonKey(defaultValue: '')
  String content;

  @JsonKey(defaultValue: '')
  String urlToImage;

  @JsonKey(defaultValue: 0)
  int publishedAt;

  @JsonKey(defaultValue: 0)
  int createdTime;

  @JsonKey(defaultValue: [])
  List<String> a;

  BlogModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.url = '',
    this.content = '',
    this.urlToImage = '',
    this.publishedAt = 0,
    this.createdTime = 0,
    this.a =const [],
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}
