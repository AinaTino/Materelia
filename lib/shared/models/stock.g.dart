// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Stock _$StockFromJson(Map<String, dynamic> json) => _Stock(
  id_stock: json['id_stock'] as String,
  nom: json['nom'] as String,
  id_zone: json['id_zone'] as String,
  created_at: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$StockToJson(_Stock instance) => <String, dynamic>{
  'id_stock': instance.id_stock,
  'nom': instance.nom,
  'id_zone': instance.id_zone,
  'created_at': instance.created_at?.toIso8601String(),
};
