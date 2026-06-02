
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categorie.freezed.dart';
part 'categorie.g.dart';

@freezed
abstract class Categorie with _$Categorie {
  const factory Categorie({
    required String id_categorie,
    required String nom,
    String? description,
    DateTime? created_at
  }) = _Categorie;
	
  factory Categorie.fromJson(Map<String, dynamic> json) =>
			_$CategorieFromJson(json);
}
