// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Notification _$NotificationFromJson(Map<String, dynamic> json) =>
    _Notification(
      id: json['id_notification'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      dateEnvoi: json['date_envoi'] == null
          ? null
          : DateTime.parse(json['date_envoi'] as String),
      lu: json['lu'] as bool?,
      idUtilisateur: json['id_utilisateur'] as String,
      route: json['route'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$NotificationToJson(_Notification instance) =>
    <String, dynamic>{
      'id_notification': instance.id,
      'message': instance.message,
      'type': instance.type,
      'date_envoi': instance.dateEnvoi?.toIso8601String(),
      'lu': instance.lu,
      'id_utilisateur': instance.idUtilisateur,
      'route': instance.route,
      'created_at': instance.createdAt?.toIso8601String(),
    };
