
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categorie.freezed.dart';
part 'categorie.g.dart';

@freezed
abstract class Categorie with _$Categorie {
  const factory Categorie({
    @JsonKey(name: 'id_categorie') required String id,
    @JsonKey(name: 'nom') required String nom,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Categorie;
	
  factory Categorie.fromJson(Map<String, dynamic> json) =>
			_$CategorieFromJson(json);
}
