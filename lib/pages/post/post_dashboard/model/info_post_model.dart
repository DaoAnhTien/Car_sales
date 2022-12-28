import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/model/info_value.dart';
part 'info_post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InfoPostModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String column;

  @JsonKey(defaultValue: <InfoValueModel>[])
  List<InfoValueModel> listvalue;

  InfoPostModel({this.column = '', this.listvalue = const <InfoValueModel>[]});

  factory InfoPostModel.fromJson(Map<String, dynamic> json) =>
      _$InfoPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoPostModelToJson(this);
}
