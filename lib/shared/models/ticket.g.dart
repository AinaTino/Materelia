// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id_ticket: json['id_ticket'] as String,
  lieu_utilisation: json['lieu_utilisation'] as String,
  date_fin_prevue: DateTime.parse(json['date_fin_prevue'] as String),
  date_creation: json['date_creation'] == null
      ? null
      : DateTime.parse(json['date_creation'] as String),
  etat: json['etat'] as String,
  code_remise: (json['code_remise'] as num?)?.toInt(),
  date_expiration_code: json['date_expiration_code'] == null
      ? null
      : DateTime.parse(json['date_expiration_code'] as String),
  date_validation: json['date_validation'] == null
      ? null
      : DateTime.parse(json['date_validation'] as String),
  motif_refus: json['motif_refus'] as String?,
  id_demandeur: json['id_demandeur'] as String,
  id_valideur: json['id_valideur'] as String?,
  id_remetteur: json['id_remetteur'] as String?,
  id_zone: json['id_zone'] as String,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id_ticket': instance.id_ticket,
  'lieu_utilisation': instance.lieu_utilisation,
  'date_fin_prevue': instance.date_fin_prevue.toIso8601String(),
  'date_creation': instance.date_creation?.toIso8601String(),
  'etat': instance.etat,
  'code_remise': instance.code_remise,
  'date_expiration_code': instance.date_expiration_code?.toIso8601String(),
  'date_validation': instance.date_validation?.toIso8601String(),
  'motif_refus': instance.motif_refus,
  'id_demandeur': instance.id_demandeur,
  'id_valideur': instance.id_valideur,
  'id_remetteur': instance.id_remetteur,
  'id_zone': instance.id_zone,
  'created_at': instance.created_at?.toIso8601String(),
};
