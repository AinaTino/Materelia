
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gerer.freezed.dart';
part 'gerer.g.dart';

@freezed
abstract class Gerer with _$Gerer {
  const factory Gerer({
    @JsonKey(name: 'id_utilisateur') required String idUtilisateur,
    @JsonKey(name: 'id_zone') required String idZone,
  }) = _Gerer;
	
  factory Gerer.fromJson(Map<String, dynamic> json) =>
			_$GererFromJson(json);
}

