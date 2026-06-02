// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Notification _$NotificationFromJson(Map<String, dynamic> json) =>
    _Notification(
      id_notification: json['id_notification'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      date_envoi: json['date_envoi'] == null
          ? null
          : DateTime.parse(json['date_envoi'] as String),
      lu: json['lu'] as bool?,
      id_utilisateur: json['id_utilisateur'] as String,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationToJson(_Notification instance) =>
    <String, dynamic>{
      'id_notification': instance.id_notification,
      'message': instance.message,
      'type': instance.type,
      'date_envoi': instance.date_envoi?.toIso8601String(),
      'lu': instance.lu,
      'id_utilisateur': instance.id_utilisateur,
      'created_at': instance.created_at?.toIso8601String(),
    };
