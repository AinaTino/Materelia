
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gerer.freezed.dart';
part 'gerer.g.dart';

@freezed
abstract class Gerer with _$Gerer {
  const factory Gerer({
    required String id_utilisateur,
    required String id_zone,
  }) = _Gerer;
	
  factory Gerer.fromJson(Map<String, dynamic> json) =>
			_$GererFromJson(json);
}

