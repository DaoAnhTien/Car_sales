// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowRoomModel _$ShowRoomModelFromJson(Map<String, dynamic> json) =>
    ShowRoomModel(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      link: json['link'] as String? ?? '',
      image: json['image'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );

Map<String, dynamic> _$ShowRoomModelToJson(ShowRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'link': instance.link,
      'phone': instance.phone,
      'address': instance.address,
      'image': instance.image,
    };
