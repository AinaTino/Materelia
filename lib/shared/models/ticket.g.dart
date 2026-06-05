// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id: json['id_ticket'] as String,
  lieuUtilisation: json['lieu_utilisation'] as String,
  dateFinPrevue: DateTime.parse(json['date_fin_prevue'] as String),
  dateCreation: json['date_creation'] == null
      ? null
      : DateTime.parse(json['date_creation'] as String),
  etat: json['etat'] as String,
  codeRemise: (json['code_remise'] as num?)?.toInt(),
  dateExpirationCode: json['date_expiration_code'] == null
      ? null
      : DateTime.parse(json['date_expiration_code'] as String),
  dateValidation: json['date_validation'] == null
      ? null
      : DateTime.parse(json['date_validation'] as String),
  motifRefus: json['motif_refus'] as String?,
  idDemandeur: json['id_demandeur'] as String,
  idValideur: json['id_valideur'] as String?,
  idRemetteur: json['id_remetteur'] as String?,
  idZone: json['id_zone'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id_ticket': instance.id,
  'lieu_utilisation': instance.lieuUtilisation,
  'date_fin_prevue': instance.dateFinPrevue.toIso8601String(),
  'date_creation': instance.dateCreation?.toIso8601String(),
  'etat': instance.etat,
  'code_remise': instance.codeRemise,
  'date_expiration_code': instance.dateExpirationCode?.toIso8601String(),
  'date_validation': instance.dateValidation?.toIso8601String(),
  'motif_refus': instance.motifRefus,
  'id_demandeur': instance.idDemandeur,
  'id_valideur': instance.idValideur,
  'id_remetteur': instance.idRemetteur,
  'id_zone': instance.idZone,
  'created_at': instance.createdAt?.toIso8601String(),
};
