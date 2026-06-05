// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilisateur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Utilisateur _$UtilisateurFromJson(Map<String, dynamic> json) => _Utilisateur(
  id: json['id_utilisateur'] as String,
  nom: json['nom'] as String,
  prenom: json['prenom'] as String,
  role: json['role'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UtilisateurToJson(_Utilisateur instance) =>
    <String, dynamic>{
      'id_utilisateur': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'role': instance.role,
      'created_at': instance.createdAt?.toIso8601String(),
    };
