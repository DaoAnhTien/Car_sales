// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarCompanyModel _$CarCompanyModelFromJson(Map<String, dynamic> json) =>
    CarCompanyModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] == null
          ? null
          : ImageModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarCompanyModelToJson(CarCompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar?.toJson(),
    };
