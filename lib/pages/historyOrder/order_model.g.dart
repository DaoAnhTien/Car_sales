// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String? ?? '',
      buyerId: json['buyerId'] as String? ?? '',
      sellerId: json['sellerId'] as String? ?? '',
      orderStatus: json['orderStatus'] as String? ?? '',
      bookingDate: json['bookingDate'] == null
          ? null
          : DateTime.parse(json['bookingDate'] as String),
      paymentStatus: json['paymentStatus'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      buyer: json['buyer'] == null
          ? null
          : UserModel.fromJson(json['buyer'] as Map<String, dynamic>),
      seller: json['seller'] == null
          ? null
          : UserModel.fromJson(json['seller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'orderStatus': instance.orderStatus,
      'bookingDate': instance.bookingDate?.toIso8601String(),
      'paymentStatus': instance.paymentStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'product': instance.product?.toJson(),
      'buyer': instance.buyer?.toJson(),
      'seller': instance.seller?.toJson(),
    };
