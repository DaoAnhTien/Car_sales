import 'package:json_annotation/json_annotation.dart';
import 'package:oke_car_flutter/models/base_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel extends BaseModel {
  @JsonKey(defaultValue: '')
  String id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String message;

  @JsonKey(defaultValue: false)
  bool isRead;

  DateTime? createdAt;

  NotificationModel({
    this.id = '',
    this.title = '',
    this.message = '',
    this.isRead = false,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
