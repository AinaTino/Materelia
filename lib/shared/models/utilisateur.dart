
import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilisateur.freezed.dart';
part 'utilisateur.g.dart';

@freezed
abstract class Utilisateur with _$Utilisateur {
  const factory Utilisateur({
    @JsonKey(name: 'id_utilisateur') required String id,
    @JsonKey(name: 'nom') required String nom,
    @JsonKey(name: 'prenom') required String prenom,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Utilisateur;
	
  factory Utilisateur.fromJson(Map<String, dynamic> json) =>
			_$UtilisateurFromJson(json);
}
