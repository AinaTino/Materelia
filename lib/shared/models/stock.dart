
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    required String id_stock,
    required String nom,
    required String id_zone,
    DateTime? created_at
  }) = _Stock;
	
  factory Stock.fromJson(Map<String, dynamic> json) =>
			_$StockFromJson(json);
}
