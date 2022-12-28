import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String deviceId;

  @JsonKey(defaultValue: '')
  String deviceName;

  DeviceModel({
    required this.deviceId,
    required this.deviceName,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
