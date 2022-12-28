// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      content: json['content'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ?? '',
      publishedAt: json['publishedAt'] as int? ?? 0,
      createdTime: json['createdTime'] as int? ?? 0,
      a: (json['a'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'content': instance.content,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'createdTime': instance.createdTime,
      'a': instance.a,
    };
