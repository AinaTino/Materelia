// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ligneticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LigneTicket _$LigneTicketFromJson(Map<String, dynamic> json) => _LigneTicket(
  id_ligne_ticket: json['id_ligne_ticket'] as String,
  id_ticket: json['id_ticket'] as String,
  id_materiel: json['id_materiel'] as String,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$LigneTicketToJson(_LigneTicket instance) =>
    <String, dynamic>{
      'id_ligne_ticket': instance.id_ligne_ticket,
      'id_ticket': instance.id_ticket,
      'id_materiel': instance.id_materiel,
      'created_at': instance.created_at?.toIso8601String(),
    };
