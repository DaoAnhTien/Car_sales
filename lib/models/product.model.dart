import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/models/image_model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';

part 'product.model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: 0)
  int price;

  @JsonKey(defaultValue: 0)
  int year;

  @JsonKey(defaultValue: '')
  String carCompanyId;

  @JsonKey(defaultValue: '')
  String versionId;

  @JsonKey(defaultValue: '')
  String carStatus;

  @JsonKey(defaultValue: '')
  String origin;

  @JsonKey(defaultValue: '')
  String gear;

  @JsonKey(defaultValue: '')
  String fuel;

  @JsonKey(defaultValue: '')
  String color;

  @JsonKey(defaultValue: '')
  String vehicleQuality;

  @JsonKey(defaultValue: '')
  String description;

  @JsonKey(defaultValue: '')
  String location;

  @JsonKey(defaultValue: '')
  String userId;

  @JsonKey(defaultValue: <ImageModel>[])
  List<ImageModel> avatar;

  @JsonKey(defaultValue: '')
  String status;

  @JsonKey(defaultValue: '')
  String addressSeller;

  @JsonKey(defaultValue: '')
  String phoneSeller;

  @JsonKey(defaultValue: '')
  String nameSeller;

  DateTime? createdAt;

  CarCompanyModel? company;

  UserModel? user;

  ProductModel(
      {this.id = '',
      this.title = '',
      this.nameSeller = '',
      this.addressSeller = '',
      this.phoneSeller = '',
      this.price = 0,
      this.year = 0,
      this.carCompanyId = '',
      this.versionId = '',
      this.carStatus = '',
      this.origin = '',
      this.gear = '',
      this.fuel = '',
      this.color = '',
      this.vehicleQuality = '',
      this.description = '',
      this.location = '',
      this.userId = '',
      this.avatar = const <ImageModel>[],
      this.status = '',
      this.createdAt,
      this.company,
      this.user});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
