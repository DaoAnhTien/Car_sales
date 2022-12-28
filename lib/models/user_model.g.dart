// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] == null ? '' : fields[0] as String,
      userName: fields[1] == null ? '' : fields[1] as String,
      avatar: fields[4] as ImageModel?,
      fullName: fields[6] == null ? '' : fields[6] as String,
      role: fields[7] == null ? '' : fields[7] as String,
      birthday: fields[8] == null ? 0 : fields[8] as int,
      address: fields[5] == null ? '' : fields[5] as String,
      email: fields[2] == null ? '' : fields[2] as String,
      storeInfo: fields[9] as StoreModel?,
      phone: fields[3] == null ? '' : fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.fullName)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.birthday)
      ..writeByte(9)
      ..write(obj.storeInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      avatar: json['avatar'] == null
          ? null
          : ImageModel.fromJson(json['avatar'] as Map<String, dynamic>),
      fullName: json['fullName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      birthday: json['birthday'] as int? ?? 0,
      address: json['address'] as String? ?? '',
      email: json['email'] as String? ?? '',
      storeInfo: json['storeInfo'] == null
          ? null
          : StoreModel.fromJson(json['storeInfo'] as Map<String, dynamic>),
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
      'avatar': instance.avatar?.toJson(),
      'address': instance.address,
      'fullName': instance.fullName,
      'role': instance.role,
      'birthday': instance.birthday,
      'storeInfo': instance.storeInfo?.toJson(),
    };
