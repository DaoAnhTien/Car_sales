import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';
import 'package:oke_car_flutter/models/product.model.dart';
import 'package:oke_car_flutter/models/user_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String buyerId;

  @JsonKey(defaultValue: '')
  String sellerId;

  @JsonKey(defaultValue: '')
  String orderStatus;

  DateTime? bookingDate;

  @JsonKey(defaultValue: '')
  String paymentStatus;

  DateTime? createdAt;

  ProductModel? product;

  UserModel? buyer;

  UserModel? seller;

  OrderModel(
      {this.id = '',
      this.buyerId = '',
      this.sellerId = '',
      this.orderStatus = '',
      this.bookingDate,
      this.paymentStatus = '',
      this.createdAt,
      this.product,
      this.buyer,
      this.seller});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
