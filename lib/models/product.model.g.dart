// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      nameSeller: json['nameSeller'] as String? ?? '',
      addressSeller: json['addressSeller'] as String? ?? '',
      phoneSeller: json['phoneSeller'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      year: json['year'] as int? ?? 0,
      carCompanyId: json['carCompanyId'] as String? ?? '',
      versionId: json['versionId'] as String? ?? '',
      carStatus: json['carStatus'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      gear: json['gear'] as String? ?? '',
      fuel: json['fuel'] as String? ?? '',
      color: json['color'] as String? ?? '',
      vehicleQuality: json['vehicleQuality'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      avatar: (json['avatar'] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      company: json['company'] == null
          ? null
          : CarCompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'year': instance.year,
      'carCompanyId': instance.carCompanyId,
      'versionId': instance.versionId,
      'carStatus': instance.carStatus,
      'origin': instance.origin,
      'gear': instance.gear,
      'fuel': instance.fuel,
      'color': instance.color,
      'vehicleQuality': instance.vehicleQuality,
      'description': instance.description,
      'location': instance.location,
      'userId': instance.userId,
      'avatar': instance.avatar.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'addressSeller': instance.addressSeller,
      'phoneSeller': instance.phoneSeller,
      'nameSeller': instance.nameSeller,
      'createdAt': instance.createdAt?.toIso8601String(),
      'company': instance.company?.toJson(),
      'user': instance.user?.toJson(),
    };
