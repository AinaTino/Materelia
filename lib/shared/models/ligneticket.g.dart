// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ligneticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LigneTicket _$LigneTicketFromJson(Map<String, dynamic> json) => _LigneTicket(
  id: json['id_ligne_ticket'] as String,
  idTicket: json['id_ticket'] as String,
  idMateriel: json['id_materiel'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$LigneTicketToJson(_LigneTicket instance) =>
    <String, dynamic>{
      'id_ligne_ticket': instance.id,
      'id_ticket': instance.idTicket,
      'id_materiel': instance.idMateriel,
      'created_at': instance.createdAt?.toIso8601String(),
    };
