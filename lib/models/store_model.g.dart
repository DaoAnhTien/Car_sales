// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreModelAdapter extends TypeAdapter<StoreModel> {
  @override
  final int typeId = 5;

  @override
  StoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModel(
      avatar: fields[3] as ImageModel?,
      nameStore: fields[0] == null ? '' : fields[0] as String,
      phoneStore: fields[1] == null ? '' : fields[1] as String,
      addressStore: fields[2] == null ? '' : fields[2] as String,
      banner: fields[4] as ImageModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nameStore)
      ..writeByte(1)
      ..write(obj.phoneStore)
      ..writeByte(2)
      ..write(obj.addressStore)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.banner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      avatar: json['avatar'] == null
          ? null
          : ImageModel.fromJson(json['avatar'] as Map<String, dynamic>),
      nameStore: json['nameStore'] as String? ?? '',
      phoneStore: json['phoneStore'] as String? ?? '',
      addressStore: json['addressStore'] as String? ?? '',
      banner: json['banner'] == null
          ? null
          : ImageModel.fromJson(json['banner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'nameStore': instance.nameStore,
      'phoneStore': instance.phoneStore,
      'addressStore': instance.addressStore,
      'avatar': instance.avatar?.toJson(),
      'banner': instance.banner?.toJson(),
    };
