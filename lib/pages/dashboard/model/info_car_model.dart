import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'info_car_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InfoCarModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String location;

  @JsonKey(defaultValue: '')
  String namsx;

  @JsonKey(defaultValue: '')
  String tinhtrang;

  InfoCarModel({this.location = '', this.namsx = '', this.tinhtrang = ''});

  factory InfoCarModel.fromJson(Map<String, dynamic> json) =>
      _$InfoCarModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoCarModelToJson(this);
}
