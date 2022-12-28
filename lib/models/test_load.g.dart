// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_load.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestLoading _$TestLoadingFromJson(Map<String, dynamic> json) => TestLoading(
      offset: json['offset'] as int? ?? 0,
      total_size: json['total_size'] as int? ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => CarModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TestLoadingToJson(TestLoading instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'total_size': instance.total_size,
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
