import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'info_value.g.dart';

@JsonSerializable(explicitToJson: true)
class InfoValueModel extends BaseModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: '')
  String title;


  InfoValueModel({this.id = 0, this.title = ''});

  factory InfoValueModel.fromJson(Map<String, dynamic> json) =>
      _$InfoValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoValueModelToJson(this);
}