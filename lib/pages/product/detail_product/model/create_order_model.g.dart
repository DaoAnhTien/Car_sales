// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderModel _$CreateOrderModelFromJson(Map<String, dynamic> json) =>
    CreateOrderModel(
      bookingDate: json['bookingDate'] == null
          ? null
          : DateTime.parse(json['bookingDate'] as String),
    );

Map<String, dynamic> _$CreateOrderModelToJson(CreateOrderModel instance) =>
    <String, dynamic>{
      'bookingDate': instance.bookingDate?.toIso8601String(),
    };
