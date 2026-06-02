
import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilisateur.freezed.dart';
part 'utilisateur.g.dart';

@freezed
abstract class Utilisateur with _$Utilisateur {
  const factory Utilisateur({
    required String id_utilisateur,
    required String nom,
    required String prenom,
    required String role,
    DateTime? created_at,
  }) = _Utilisateur;
	
  factory Utilisateur.fromJson(Map<String, dynamic> json) =>
			_$UtilisateurFromJson(json);
}
