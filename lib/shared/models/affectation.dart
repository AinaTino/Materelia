import 'package:freezed_annotation/freezed_annotation.dart';

part 'affectation.freezed.dart';
part 'affectation.g.dart';

@freezed
abstract class Affectation with _$Affectation {
  const factory Affectation({
    @JsonKey(name: 'id_affectation') required String id,
    @JsonKey(name: 'date_debut') required DateTime dateDebut,
    @JsonKey(name: 'date_fin_prevue') required DateTime dateFinPrevue,
    @JsonKey(name: 'date_fin_effective') DateTime? dateFinEffective,
    @JsonKey(name: 'etat') required String etat,
    @JsonKey(name: 'id_materiel') required String idMateriel,
    @JsonKey(name: 'id_beneficiaire') required String idBeneficiaire,
    @JsonKey(name: 'id_demande') required String idDemande,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // ↓ supprime ou rends nullable selon si tu en as besoin
    // @JsonKey(name: 'date_fin') DateTime? dateFin,
  }) = _Affectation;

  factory Affectation.fromJson(Map<String, dynamic> json) =>
      _$AffectationFromJson(json);
}
