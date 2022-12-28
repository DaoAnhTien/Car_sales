import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'news_info_car.g.dart';
@JsonSerializable(explicitToJson: true)
class NewInfoCar extends BaseModel {
  @JsonKey(defaultValue: '')
  String location;

  @JsonKey(defaultValue: 0)
  int namsx;

  @JsonKey(defaultValue: '')
  String tinhtrang;

  NewInfoCar({this.location = '', this.namsx = 0, this.tinhtrang = ''});

  factory NewInfoCar.fromJson(Map<String, dynamic> json) =>
      _$NewInfoCarFromJson(json);

  Map<String, dynamic> toJson() => _$NewInfoCarToJson(this);
}
