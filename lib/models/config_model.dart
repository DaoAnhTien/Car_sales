
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class ConfigModel extends HiveObject {
  @HiveField(0, defaultValue: '')
  @JsonKey(defaultValue: '')
  String name;

  @HiveField(1)
  dynamic value;

  ConfigModel(this.name, this.value);

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
