// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materiel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Materiel _$MaterielFromJson(Map<String, dynamic> json) => _Materiel(
  id_materiel: json['id_materiel'] as String,
  nom: json['nom'] as String,
  reference: json['reference'] as String,
  description: json['description'] as String?,
  etat: json['etat'] as String,
  date_acquisition: json['date_acquisition'] as String,
  id_categorie: json['id_categorie'] as String,
  id_stock: json['id_stock'] as String,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$MaterielToJson(_Materiel instance) => <String, dynamic>{
  'id_materiel': instance.id_materiel,
  'nom': instance.nom,
  'reference': instance.reference,
  'description': instance.description,
  'etat': instance.etat,
  'date_acquisition': instance.date_acquisition,
  'id_categorie': instance.id_categorie,
  'id_stock': instance.id_stock,
  'created_at': instance.created_at?.toIso8601String(),
};
