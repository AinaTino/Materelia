
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materiel.freezed.dart';
part 'materiel.g.dart';

@freezed
abstract class Materiel with _$Materiel {
  const factory Materiel({
    @JsonKey(name: 'id_materiel') required String id,
    @JsonKey(name: 'nom') required String nom,
    @JsonKey(name: 'reference') required String reference,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'etat') required String etat,
    @JsonKey(name: 'date_acquisition') required String dateAcquisition,
    @JsonKey(name: 'id_categorie') required String idCategorie,
    @JsonKey(name: 'id_stock') required String idStock,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Materiel;
	
  factory Materiel.fromJson(Map<String, dynamic> json) =>
			_$MaterielFromJson(json);
}
