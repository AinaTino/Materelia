
import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
abstract class Zone with _$Zone {
  const factory Zone({
    @JsonKey(name: 'id_zone') required String id,
    @JsonKey(name: 'nom') required String nom,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Zone;
	
  factory Zone.fromJson(Map<String, dynamic> json) =>
			_$ZoneFromJson(json);
}
