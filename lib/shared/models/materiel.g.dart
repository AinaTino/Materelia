// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materiel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Materiel _$MaterielFromJson(Map<String, dynamic> json) => _Materiel(
  id: json['id_materiel'] as String,
  nom: json['nom'] as String,
  reference: json['reference'] as String,
  description: json['description'] as String?,
  etat: json['etat'] as String,
  dateAcquisition: json['date_acquisition'] as String,
  idCategorie: json['id_categorie'] as String,
  idStock: json['id_stock'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$MaterielToJson(_Materiel instance) => <String, dynamic>{
  'id_materiel': instance.id,
  'nom': instance.nom,
  'reference': instance.reference,
  'description': instance.description,
  'etat': instance.etat,
  'date_acquisition': instance.dateAcquisition,
  'id_categorie': instance.idCategorie,
  'id_stock': instance.idStock,
  'created_at': instance.createdAt?.toIso8601String(),
};
