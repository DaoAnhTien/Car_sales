// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPostModel _$MyPostModelFromJson(Map<String, dynamic> json) => MyPostModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      stt: json['stt'] as int? ?? 0,
      uptime: json['uptime'] as int? ?? 0,
    );

Map<String, dynamic> _$MyPostModelToJson(MyPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'stt': instance.stt,
      'uptime': instance.uptime,
    };
