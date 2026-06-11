import 'package:freezed_annotation/freezed_annotation.dart';

part 'demandes_affectations.freezed.dart';
part 'demandes_affectations.g.dart';

@freezed
abstract class DemandesAffectation with _$DemandesAffectation {
  const factory DemandesAffectation({
    @JsonKey(name: 'id_demande') required String id,
    
    @JsonKey(name: 'date_demande') DateTime? dateDemande,

    @JsonKey(name: 'justification') required String justification,

    @JsonKey(name: 'etat') required String etat,

    @JsonKey(name: 'motif_refus') String? motifRefus,

    @JsonKey(name: 'service_beneficiaire') required String serviceBeneficiaire,

    @JsonKey(name: 'date_debut') DateTime? dateDebut,

    @JsonKey(name: 'date_fin_prevue') DateTime? dateFinPrevue,

    @JsonKey(name: 'id_demandeur') required String idDemandeur,

    @JsonKey(name: 'id_valideur') String? idValideur,

    @JsonKey(name: 'id_categorie') required String idCategorie,

    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _DemandesAffectation;

  factory DemandesAffectation.fromJson(Map<String, dynamic> json) =>
      _$DemandesAffectationFromJson(json);
}