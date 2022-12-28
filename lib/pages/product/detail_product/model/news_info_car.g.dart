// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_info_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewInfoCar _$NewInfoCarFromJson(Map<String, dynamic> json) => NewInfoCar(
      location: json['location'] as String? ?? '',
      namsx: json['namsx'] as int? ?? 0,
      tinhtrang: json['tinhtrang'] as String? ?? '',
    );

Map<String, dynamic> _$NewInfoCarToJson(NewInfoCar instance) =>
    <String, dynamic>{
      'location': instance.location,
      'namsx': instance.namsx,
      'tinhtrang': instance.tinhtrang,
    };
