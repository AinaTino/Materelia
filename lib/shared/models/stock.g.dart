// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Stock _$StockFromJson(Map<String, dynamic> json) => _Stock(
  id: json['id_stock'] as String,
  nom: json['nom'] as String,
  idZone: json['id_zone'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$StockToJson(_Stock instance) => <String, dynamic>{
  'id_stock': instance.id,
  'nom': instance.nom,
  'id_zone': instance.idZone,
  'created_at': instance.createdAt?.toIso8601String(),
};
