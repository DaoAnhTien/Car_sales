import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image_model.dart';

part 'store_model.g.dart';
@HiveType(typeId: 5)
@JsonSerializable(explicitToJson: true)
class StoreModel extends HiveObject {
  @HiveField(0, defaultValue: '')
  @JsonKey(defaultValue: '')
  String nameStore;

  @HiveField(1, defaultValue: '')
  @JsonKey(defaultValue: '')
  String phoneStore;

  @HiveField(2, defaultValue: '')
  @JsonKey(defaultValue: '')
  String addressStore;

  @HiveField(3)
  ImageModel? avatar;

  @HiveField(4)
  ImageModel? banner;

  StoreModel({
    this.avatar,
    this.nameStore = '',
    this.phoneStore = '',
    this.addressStore = '',
    this.banner,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
