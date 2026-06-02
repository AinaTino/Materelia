// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Categorie _$CategorieFromJson(Map<String, dynamic> json) => _Categorie(
  id_categorie: json['id_categorie'] as String,
  nom: json['nom'] as String,
  description: json['description'] as String?,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CategorieToJson(_Categorie instance) =>
    <String, dynamic>{
      'id_categorie': instance.id_categorie,
      'nom': instance.nom,
      'description': instance.description,
      'created_at': instance.created_at?.toIso8601String(),
    };
