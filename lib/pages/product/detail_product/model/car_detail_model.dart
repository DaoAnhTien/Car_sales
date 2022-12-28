import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/info_car_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/pages/product/detail_product/model/news_info_car.dart';

part 'car_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailCarModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: <InfoCarModel>[])
  List<NewInfoCar> infocar;

  @JsonKey(defaultValue: '')
  String added_by;

  @JsonKey(defaultValue: '')
  String phone;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String slug;

  @JsonKey(defaultValue: '')
  String sku;

  @JsonKey(defaultValue: 0)
  int user_id;

  @JsonKey(defaultValue: 0)
  int brand_id;

  @JsonKey(defaultValue: '')
  String thumbnail;

  @JsonKey(defaultValue: 0.0)
  double price;

  @JsonKey(defaultValue: '')
  String price_text;

  @JsonKey(defaultValue: '')
  String video_url;

  @JsonKey(defaultValue: '')
  String unit;

  @JsonKey(defaultValue: '')
  String details;

  DateTime? created_at;

  @JsonKey(defaultValue: 0)
  int tinvip;

  @JsonKey(defaultValue: <String>[])
  List<String> images;

  DetailCarModel(
      {this.id = 0,
        this.infocar = const <NewInfoCar>[],
        this.added_by = '',
        this.name = '',
        this.slug = '',
        this.sku = '',
        this.user_id = 0,
        this.brand_id = 0,
        this.thumbnail = '',
        this.video_url = '',
        this.price = 0.0,
        this.details = '',
        this.price_text = '',
        this.created_at,
        this.phone = '',
        this.tinvip = 0,
        this.images = const <String>[],
        this.unit = ''});

  factory DetailCarModel.fromJson(Map<String, dynamic> json) =>
      _$DetailCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCarModelToJson(this);
}
