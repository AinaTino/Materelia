
import 'package:freezed_annotation/freezed_annotation.dart';

part 'affectation.freezed.dart';
part 'affectation.g.dart';

@freezed
abstract class Affectation with _$Affectation {
  const factory Affectation({
    required String id_affectation,
    required DateTime date_debut,
    required DateTime date_fin_prevue,
    DateTime? date_fin_effective,
    required String etat,
    required String id_materiel,
    required String id_beneficiaire,
    required String id_demande,
    required DateTime date_fin
  }) = _Affectation;
	
  factory Affectation.fromJson(Map<String, dynamic> json) =>
			_$AffectationFromJson(json);
}
