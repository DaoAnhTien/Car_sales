// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoPostModel _$InfoPostModelFromJson(Map<String, dynamic> json) =>
    InfoPostModel(
      column: json['column'] as String? ?? '',
      listvalue: (json['listvalue'] as List<dynamic>?)
              ?.map((e) => InfoValueModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$InfoPostModelToJson(InfoPostModel instance) =>
    <String, dynamic>{
      'column': instance.column,
      'listvalue': instance.listvalue.map((e) => e.toJson()).toList(),
    };
