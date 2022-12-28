// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUploadModel _$ImageUploadModelFromJson(Map<String, dynamic> json) =>
    ImageUploadModel(
      file: json['file'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$ImageUploadModelToJson(ImageUploadModel instance) =>
    <String, dynamic>{
      'file': instance.file,
      'name': instance.name,
    };
