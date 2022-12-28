import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/store_model.dart';

import 'image_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class UserModel extends HiveObject {
  @HiveField(0, defaultValue: '')
  @JsonKey(defaultValue: '')
  String id;

  @HiveField(1, defaultValue: '')
  @JsonKey(defaultValue: '')
  String userName;

  @HiveField(2, defaultValue: '')
  @JsonKey(defaultValue: '')
  String email;

  @HiveField(3, defaultValue: '')
  @JsonKey(defaultValue: '')
  String phone;

  @HiveField(4)
  ImageModel? avatar;

  @HiveField(5, defaultValue: '')
  @JsonKey(defaultValue: '')
  String address;

  @HiveField(6, defaultValue: '')
  @JsonKey(defaultValue: '')
  String fullName;

  @HiveField(7, defaultValue: '')
  @JsonKey(defaultValue: '')
  String role;

  @HiveField(8, defaultValue:0)
  @JsonKey(defaultValue: 0)
  int birthday;

  @HiveField(9)
  StoreModel? storeInfo;

  UserModel({
    this.id = '',
    this.userName = '',
    this.avatar,
    this.fullName = '',
    this.role = '',
    this.birthday = 0,
    this.address = '',
    this.email = '',
    this.storeInfo,
    this.phone = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
