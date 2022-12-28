// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaPaginationModel _$MetaPaginationModelFromJson(Map<String, dynamic> json) =>
    MetaPaginationModel(
      limit: json['limit'] as int? ?? 0,
      offset: json['offset'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );

Map<String, dynamic> _$MetaPaginationModelToJson(
        MetaPaginationModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'totalPages': instance.totalPages,
    };
