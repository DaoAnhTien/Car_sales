// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewModel _$NewModelFromJson(Map<String, dynamic> json) => NewModel(
      total_size: json['total_size'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
      offset: json['offset'] as int? ?? 0,
      blogs: (json['blogs'] as List<dynamic>?)
              ?.map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$NewModelToJson(NewModel instance) => <String, dynamic>{
      'total_size': instance.total_size,
      'limit': instance.limit,
      'offset': instance.offset,
      'blogs': instance.blogs.map((e) => e.toJson()).toList(),
    };
