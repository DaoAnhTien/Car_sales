// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int? ?? 0,
      hangxeid: json['hangxeid'] as int? ?? 0,
      dongxeid: json['dongxeid'] as int? ?? 0,
      namsx: json['namsx'] as String? ?? '',
      phienban: json['phienban'] as String? ?? '',
      giaban: json['giaban'] as String? ?? '',
      fileupload: json['fileupload'] as String? ?? '',
      title: json['title'] as String? ?? '',
      mota: json['mota'] as String? ?? '',
      video: json['video'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'hangxeid': instance.hangxeid,
      'dongxeid': instance.dongxeid,
      'namsx': instance.namsx,
      'phienban': instance.phienban,
      'giaban': instance.giaban,
      'fileupload': instance.fileupload,
      'title': instance.title,
      'mota': instance.mota,
      'video': instance.video,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'address': instance.address,
      'location': instance.location,
    };
