// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailCarModel _$DetailCarModelFromJson(Map<String, dynamic> json) =>
    DetailCarModel(
      id: json['id'] as int? ?? 0,
      infocar: (json['infocar'] as List<dynamic>?)
              ?.map((e) => NewInfoCar.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      added_by: json['added_by'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      user_id: json['user_id'] as int? ?? 0,
      brand_id: json['brand_id'] as int? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '',
      video_url: json['video_url'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      details: json['details'] as String? ?? '',
      price_text: json['price_text'] as String? ?? '',
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      phone: json['phone'] as String? ?? '',
      tinvip: json['tinvip'] as int? ?? 0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      unit: json['unit'] as String? ?? '',
    );

Map<String, dynamic> _$DetailCarModelToJson(DetailCarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'infocar': instance.infocar.map((e) => e.toJson()).toList(),
      'added_by': instance.added_by,
      'phone': instance.phone,
      'name': instance.name,
      'slug': instance.slug,
      'sku': instance.sku,
      'user_id': instance.user_id,
      'brand_id': instance.brand_id,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'price_text': instance.price_text,
      'video_url': instance.video_url,
      'unit': instance.unit,
      'details': instance.details,
      'created_at': instance.created_at?.toIso8601String(),
      'tinvip': instance.tinvip,
      'images': instance.images,
    };
