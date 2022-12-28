// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandCarModel _$BrandCarModelFromJson(Map<String, dynamic> json) =>
    BrandCarModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      alias: json['alias'] as String? ?? '',
    );

Map<String, dynamic> _$BrandCarModelToJson(BrandCarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'alias': instance.alias,
    };
