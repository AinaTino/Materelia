
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materiel.freezed.dart';
part 'materiel.g.dart';

@freezed
abstract class Materiel with _$Materiel {
  const factory Materiel({
    required String id_materiel,
    required String nom,
    required String reference,
    String? description,
    required String etat,
    required String date_acquisition,
    required String id_categorie,
    required String id_stock,
    DateTime? created_at
  }) = _Materiel;
	
  factory Materiel.fromJson(Map<String, dynamic> json) =>
			_$MaterielFromJson(json);
}
