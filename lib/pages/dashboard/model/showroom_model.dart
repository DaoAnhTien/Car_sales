import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'showroom_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShowRoomModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: 0)
  int userId;

  @JsonKey(defaultValue: '')
  String name;

  @JsonKey(defaultValue: '')
  String link;

  @JsonKey(defaultValue: '')
  String phone;

  @JsonKey(defaultValue: '')
  String address;

  @JsonKey(defaultValue: '')
  String image;

  ShowRoomModel(
      {this.id = 0,
      this.userId = 0,
      this.name = '',
      this.link = '',
      this.image = '',
      this.phone = '',
      this.address = ''});

  factory ShowRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ShowRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowRoomModelToJson(this);
}
