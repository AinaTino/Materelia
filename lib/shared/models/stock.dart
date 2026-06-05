
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    @JsonKey(name: 'id_stock') required String id,
    @JsonKey(name: 'nom') required String nom,
    @JsonKey(name: 'id_zone') required String idZone,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Stock;
	
  factory Stock.fromJson(Map<String, dynamic> json) =>
			_$StockFromJson(json);
}
