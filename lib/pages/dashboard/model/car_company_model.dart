import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/SubBranchModel.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/models/image_model.dart';

part 'car_company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CarCompanyModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String name;

  ImageModel? avatar;

  CarCompanyModel({this.id = '', this.name = '', this.avatar});

  factory CarCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CarCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarCompanyModelToJson(this);
}
