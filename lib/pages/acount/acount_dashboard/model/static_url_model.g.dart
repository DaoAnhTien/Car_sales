// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_url_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticUrlModel _$StaticUrlModelFromJson(Map<String, dynamic> json) =>
    StaticUrlModel(
      about_us: json['about_us'] as String? ?? '',
      priceCar: json['priceCar'] as String? ?? '',
      faq: json['faq'] as String? ?? '',
      contact_us: json['contact_us'] as String? ?? '',
      brands: json['brands'] as String? ?? '',
      tragop: json['tragop'] as String? ?? '',
      dangtin: json['dangtin'] as String? ?? '',
      categories: json['categories'] as String? ?? '',
    );

Map<String, dynamic> _$StaticUrlModelToJson(StaticUrlModel instance) =>
    <String, dynamic>{
      'about_us': instance.about_us,
      'priceCar': instance.priceCar,
      'faq': instance.faq,
      'contact_us': instance.contact_us,
      'brands': instance.brands,
      'tragop': instance.tragop,
      'dangtin': instance.dangtin,
      'categories': instance.categories,
    };
