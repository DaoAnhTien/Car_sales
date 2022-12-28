// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubBranchModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubBranchModel _$SubBranchModelFromJson(Map<String, dynamic> json) =>
    SubBranchModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      parentId: json['parentId'] as int? ?? 0,
      position: json['position'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );

Map<String, dynamic> _$SubBranchModelToJson(SubBranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'slug': instance.slug,
      'icon': instance.icon,
      'parentId': instance.parentId,
      'position': instance.position,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
