import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'static_url_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StaticUrlModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String about_us;

  @JsonKey(defaultValue: '')
  String priceCar;

  @JsonKey(defaultValue: '')
  String faq;

  @JsonKey(defaultValue: '')
  String contact_us;

  @JsonKey(defaultValue: '')
  String brands;

  @JsonKey(defaultValue: '')
  String tragop;

  @JsonKey(defaultValue: '')
  String dangtin;

  @JsonKey(defaultValue: '')
  String categories;

  StaticUrlModel(
      {this.about_us = '',
      this.priceCar = '',
      this.faq = '',
      this.contact_us = '',
      this.brands = '',
      this.tragop = '',
      this.dangtin = '',
      this.categories = ''});

  factory StaticUrlModel.fromJson(Map<String, dynamic> json) =>
      _$StaticUrlModelFromJson(json);

  Map<String, dynamic> toJson() => _$StaticUrlModelToJson(this);
}
