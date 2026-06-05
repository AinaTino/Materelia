// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affectation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Affectation _$AffectationFromJson(Map<String, dynamic> json) => _Affectation(
  id: json['id_affectation'] as String,
  dateDebut: DateTime.parse(json['date_debut'] as String),
  dateFinPrevue: DateTime.parse(json['date_fin_prevue'] as String),
  dateFinEffective: json['date_fin_effective'] == null
      ? null
      : DateTime.parse(json['date_fin_effective'] as String),
  etat: json['etat'] as String,
  idMateriel: json['id_materiel'] as String,
  idBeneficiaire: json['id_beneficiaire'] as String,
  idDemande: json['id_demande'] as String,
  dateFin: DateTime.parse(json['date_fin'] as String),
);

Map<String, dynamic> _$AffectationToJson(_Affectation instance) =>
    <String, dynamic>{
      'id_affectation': instance.id,
      'date_debut': instance.dateDebut.toIso8601String(),
      'date_fin_prevue': instance.dateFinPrevue.toIso8601String(),
      'date_fin_effective': instance.dateFinEffective?.toIso8601String(),
      'etat': instance.etat,
      'id_materiel': instance.idMateriel,
      'id_beneficiaire': instance.idBeneficiaire,
      'id_demande': instance.idDemande,
      'date_fin': instance.dateFin.toIso8601String(),
    };
