// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannerModelAdapter extends TypeAdapter<BannerModel> {
  @override
  final int typeId = 2;

  @override
  BannerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BannerModel(
      id: fields[0] == null ? 0 : fields[0] as int,
      photo: fields[1] == null ? '' : fields[1] as String,
      banner_type: fields[2] == null ? '' : fields[2] as String,
      published: fields[3] == null ? 0 : fields[3] as int,
      url: fields[4] == null ? '' : fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BannerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.photo)
      ..writeByte(2)
      ..write(obj.banner_type)
      ..writeByte(3)
      ..write(obj.published)
      ..writeByte(4)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'] as int? ?? 0,
      photo: json['photo'] as String? ?? '',
      banner_type: json['banner_type'] as String? ?? '',
      published: json['published'] as int? ?? 0,
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photo': instance.photo,
      'banner_type': instance.banner_type,
      'published': instance.published,
      'url': instance.url,
    };
