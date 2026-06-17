// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Categorie _$CategorieFromJson(Map<String, dynamic> json) => _Categorie(
  id: json['id_categorie'] as String,
  nom: json['nom'] as String,
  description: json['description'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  imageURL: json['image_url'] as String?,
);

Map<String, dynamic> _$CategorieToJson(_Categorie instance) =>
    <String, dynamic>{
      'id_categorie': instance.id,
      'nom': instance.nom,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
      'image_url': instance.imageURL,
    };
