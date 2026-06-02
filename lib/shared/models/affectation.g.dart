// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affectation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Affectation _$AffectationFromJson(Map<String, dynamic> json) => _Affectation(
  id_affectation: json['id_affectation'] as String,
  date_debut: DateTime.parse(json['date_debut'] as String),
  date_fin_prevue: DateTime.parse(json['date_fin_prevue'] as String),
  date_fin_effective: json['date_fin_effective'] == null
      ? null
      : DateTime.parse(json['date_fin_effective'] as String),
  etat: json['etat'] as String,
  id_materiel: json['id_materiel'] as String,
  id_beneficiaire: json['id_beneficiaire'] as String,
  id_demande: json['id_demande'] as String,
  date_fin: DateTime.parse(json['date_fin'] as String),
);

Map<String, dynamic> _$AffectationToJson(_Affectation instance) =>
    <String, dynamic>{
      'id_affectation': instance.id_affectation,
      'date_debut': instance.date_debut.toIso8601String(),
      'date_fin_prevue': instance.date_fin_prevue.toIso8601String(),
      'date_fin_effective': instance.date_fin_effective?.toIso8601String(),
      'etat': instance.etat,
      'id_materiel': instance.id_materiel,
      'id_beneficiaire': instance.id_beneficiaire,
      'id_demande': instance.id_demande,
      'date_fin': instance.date_fin.toIso8601String(),
    };
