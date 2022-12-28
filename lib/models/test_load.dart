import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_model.dart';
part 'test_load.g.dart';

@JsonSerializable(explicitToJson: true)
class TestLoading extends BaseModel {

  @JsonKey(defaultValue: 0)
  int offset;

  @JsonKey(defaultValue: 0)
  int total_size;

  @JsonKey(defaultValue: <CarModel>[])
  List<CarModel> products;

  TestLoading({this.offset =0, this.total_size = 0, this.products = const <CarModel>[]});

  factory TestLoading.fromJson(Map<String, dynamic> json) =>
      _$TestLoadingFromJson(json);

  Map<String, dynamic> toJson() => _$TestLoadingToJson(this);
}