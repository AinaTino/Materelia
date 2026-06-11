// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demandes_affectations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemandesAffectation _$DemandesAffectationFromJson(Map<String, dynamic> json) =>
    _DemandesAffectation(
      id: json['id_demande'] as String,
      dateDemande: json['date_demande'] == null
          ? null
          : DateTime.parse(json['date_demande'] as String),
      justification: json['justification'] as String,
      etat: json['etat'] as String,
      motifRefus: json['motif_refus'] as String?,
      serviceBeneficiaire: json['service_beneficiaire'] as String,
      dateDebut: json['date_debut'] == null
          ? null
          : DateTime.parse(json['date_debut'] as String),
      dateFinPrevue: json['date_fin_prevue'] == null
          ? null
          : DateTime.parse(json['date_fin_prevue'] as String),
      idDemandeur: json['id_demandeur'] as String,
      idValideur: json['id_valideur'] as String?,
      idCategorie: json['id_categorie'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DemandesAffectationToJson(
  _DemandesAffectation instance,
) => <String, dynamic>{
  'id_demande': instance.id,
  'date_demande': instance.dateDemande?.toIso8601String(),
  'justification': instance.justification,
  'etat': instance.etat,
  'motif_refus': instance.motifRefus,
  'service_beneficiaire': instance.serviceBeneficiaire,
  'date_debut': instance.dateDebut?.toIso8601String(),
  'date_fin_prevue': instance.dateFinPrevue?.toIso8601String(),
  'id_demandeur': instance.idDemandeur,
  'id_valideur': instance.idValideur,
  'id_categorie': instance.idCategorie,
  'created_at': instance.createdAt?.toIso8601String(),
};
