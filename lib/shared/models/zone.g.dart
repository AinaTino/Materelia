// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Zone _$ZoneFromJson(Map<String, dynamic> json) => _Zone(
  id_zone: json['id_zone'] as String,
  nom: json['nom'] as String,
  description: json['description'] as String?,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ZoneToJson(_Zone instance) => <String, dynamic>{
  'id_zone': instance.id_zone,
  'nom': instance.nom,
  'description': instance.description,
  'created_at': instance.created_at?.toIso8601String(),
};
