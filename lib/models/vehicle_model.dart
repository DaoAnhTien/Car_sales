import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'vehicle_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VehicleModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String alias;

  @JsonKey(defaultValue: '')
  String title;

  VehicleModel({
    this.id = '',
    this.name = '',
    this.alias = '',
    this.title = '',
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
