
import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
abstract class Zone with _$Zone {
  factory Zone({
    required String id_zone,
    required String nom,
    String? description,
    DateTime? created_at
  }) = _Zone;
	
  factory Zone.fromJson(Map<String, dynamic> json) =>
			_$ZoneFromJson(json);
}
