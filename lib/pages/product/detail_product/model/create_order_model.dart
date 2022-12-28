import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
part 'create_order_model.g.dart';
@JsonSerializable(explicitToJson: true)
class CreateOrderModel extends BaseModel {
  DateTime? bookingDate;
  CreateOrderModel({this.bookingDate});

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderModelToJson(this);
  
}