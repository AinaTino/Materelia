// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demandes_affectations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemandesAffectation {

@JsonKey(name: 'id_demande') String get id;@JsonKey(name: 'date_demande') DateTime? get dateDemande;@JsonKey(name: 'justification') String get justification;@JsonKey(name: 'etat') String get etat;@JsonKey(name: 'motif_refus') String? get motifRefus;@JsonKey(name: 'service_beneficiaire') String get serviceBeneficiaire;@JsonKey(name: 'date_debut') DateTime? get dateDebut;@JsonKey(name: 'date_fin_prevue') DateTime? get dateFinPrevue;@JsonKey(name: 'id_demandeur') String get idDemandeur;@JsonKey(name: 'id_valideur') String? get idValideur;@JsonKey(name: 'id_categorie') String get idCategorie;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of DemandesAffectation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemandesAffectationCopyWith<DemandesAffectation> get copyWith => _$DemandesAffectationCopyWithImpl<DemandesAffectation>(this as DemandesAffectation, _$identity);

  /// Serializes this DemandesAffectation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemandesAffectation&&(identical(other.id, id) || other.id == id)&&(identical(other.dateDemande, dateDemande) || other.dateDemande == dateDemande)&&(identical(other.justification, justification) || other.justification == justification)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.motifRefus, motifRefus) || other.motifRefus == motifRefus)&&(identical(other.serviceBeneficiaire, serviceBeneficiaire) || other.serviceBeneficiaire == serviceBeneficiaire)&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.idDemandeur, idDemandeur) || other.idDemandeur == idDemandeur)&&(identical(other.idValideur, idValideur) || other.idValideur == idValideur)&&(identical(other.idCategorie, idCategorie) || other.idCategorie == idCategorie)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateDemande,justification,etat,motifRefus,serviceBeneficiaire,dateDebut,dateFinPrevue,idDemandeur,idValideur,idCategorie,createdAt);

@override
String toString() {
  return 'DemandesAffectation(id: $id, dateDemande: $dateDemande, justification: $justification, etat: $etat, motifRefus: $motifRefus, serviceBeneficiaire: $serviceBeneficiaire, dateDebut: $dateDebut, dateFinPrevue: $dateFinPrevue, idDemandeur: $idDemandeur, idValideur: $idValideur, idCategorie: $idCategorie, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DemandesAffectationCopyWith<$Res>  {
  factory $DemandesAffectationCopyWith(DemandesAffectation value, $Res Function(DemandesAffectation) _then) = _$DemandesAffectationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_demande') String id,@JsonKey(name: 'date_demande') DateTime? dateDemande,@JsonKey(name: 'justification') String justification,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'motif_refus') String? motifRefus,@JsonKey(name: 'service_beneficiaire') String serviceBeneficiaire,@JsonKey(name: 'date_debut') DateTime? dateDebut,@JsonKey(name: 'date_fin_prevue') DateTime? dateFinPrevue,@JsonKey(name: 'id_demandeur') String idDemandeur,@JsonKey(name: 'id_valideur') String? idValideur,@JsonKey(name: 'id_categorie') String idCategorie,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$DemandesAffectationCopyWithImpl<$Res>
    implements $DemandesAffectationCopyWith<$Res> {
  _$DemandesAffectationCopyWithImpl(this._self, this._then);

  final DemandesAffectation _self;
  final $Res Function(DemandesAffectation) _then;

/// Create a copy of DemandesAffectation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dateDemande = freezed,Object? justification = null,Object? etat = null,Object? motifRefus = freezed,Object? serviceBeneficiaire = null,Object? dateDebut = freezed,Object? dateFinPrevue = freezed,Object? idDemandeur = null,Object? idValideur = freezed,Object? idCategorie = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateDemande: freezed == dateDemande ? _self.dateDemande : dateDemande // ignore: cast_nullable_to_non_nullable
as DateTime?,justification: null == justification ? _self.justification : justification // ignore: cast_nullable_to_non_nullable
as String,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,motifRefus: freezed == motifRefus ? _self.motifRefus : motifRefus // ignore: cast_nullable_to_non_nullable
as String?,serviceBeneficiaire: null == serviceBeneficiaire ? _self.serviceBeneficiaire : serviceBeneficiaire // ignore: cast_nullable_to_non_nullable
as String,dateDebut: freezed == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as DateTime?,dateFinPrevue: freezed == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime?,idDemandeur: null == idDemandeur ? _self.idDemandeur : idDemandeur // ignore: cast_nullable_to_non_nullable
as String,idValideur: freezed == idValideur ? _self.idValideur : idValideur // ignore: cast_nullable_to_non_nullable
as String?,idCategorie: null == idCategorie ? _self.idCategorie : idCategorie // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DemandesAffectation].
extension DemandesAffectationPatterns on DemandesAffectation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DemandesAffectation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DemandesAffectation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DemandesAffectation value)  $default,){
final _that = this;
switch (_that) {
case _DemandesAffectation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DemandesAffectation value)?  $default,){
final _that = this;
switch (_that) {
case _DemandesAffectation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_demande')  String id, @JsonKey(name: 'date_demande')  DateTime? dateDemande, @JsonKey(name: 'justification')  String justification, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'service_beneficiaire')  String serviceBeneficiaire, @JsonKey(name: 'date_debut')  DateTime? dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime? dateFinPrevue, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DemandesAffectation() when $default != null:
return $default(_that.id,_that.dateDemande,_that.justification,_that.etat,_that.motifRefus,_that.serviceBeneficiaire,_that.dateDebut,_that.dateFinPrevue,_that.idDemandeur,_that.idValideur,_that.idCategorie,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_demande')  String id, @JsonKey(name: 'date_demande')  DateTime? dateDemande, @JsonKey(name: 'justification')  String justification, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'service_beneficiaire')  String serviceBeneficiaire, @JsonKey(name: 'date_debut')  DateTime? dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime? dateFinPrevue, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DemandesAffectation():
return $default(_that.id,_that.dateDemande,_that.justification,_that.etat,_that.motifRefus,_that.serviceBeneficiaire,_that.dateDebut,_that.dateFinPrevue,_that.idDemandeur,_that.idValideur,_that.idCategorie,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_demande')  String id, @JsonKey(name: 'date_demande')  DateTime? dateDemande, @JsonKey(name: 'justification')  String justification, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'service_beneficiaire')  String serviceBeneficiaire, @JsonKey(name: 'date_debut')  DateTime? dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime? dateFinPrevue, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DemandesAffectation() when $default != null:
return $default(_that.id,_that.dateDemande,_that.justification,_that.etat,_that.motifRefus,_that.serviceBeneficiaire,_that.dateDebut,_that.dateFinPrevue,_that.idDemandeur,_that.idValideur,_that.idCategorie,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DemandesAffectation implements DemandesAffectation {
  const _DemandesAffectation({@JsonKey(name: 'id_demande') required this.id, @JsonKey(name: 'date_demande') this.dateDemande, @JsonKey(name: 'justification') required this.justification, @JsonKey(name: 'etat') required this.etat, @JsonKey(name: 'motif_refus') this.motifRefus, @JsonKey(name: 'service_beneficiaire') required this.serviceBeneficiaire, @JsonKey(name: 'date_debut') this.dateDebut, @JsonKey(name: 'date_fin_prevue') this.dateFinPrevue, @JsonKey(name: 'id_demandeur') required this.idDemandeur, @JsonKey(name: 'id_valideur') this.idValideur, @JsonKey(name: 'id_categorie') required this.idCategorie, @JsonKey(name: 'created_at') this.createdAt});
  factory _DemandesAffectation.fromJson(Map<String, dynamic> json) => _$DemandesAffectationFromJson(json);

@override@JsonKey(name: 'id_demande') final  String id;
@override@JsonKey(name: 'date_demande') final  DateTime? dateDemande;
@override@JsonKey(name: 'justification') final  String justification;
@override@JsonKey(name: 'etat') final  String etat;
@override@JsonKey(name: 'motif_refus') final  String? motifRefus;
@override@JsonKey(name: 'service_beneficiaire') final  String serviceBeneficiaire;
@override@JsonKey(name: 'date_debut') final  DateTime? dateDebut;
@override@JsonKey(name: 'date_fin_prevue') final  DateTime? dateFinPrevue;
@override@JsonKey(name: 'id_demandeur') final  String idDemandeur;
@override@JsonKey(name: 'id_valideur') final  String? idValideur;
@override@JsonKey(name: 'id_categorie') final  String idCategorie;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of DemandesAffectation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DemandesAffectationCopyWith<_DemandesAffectation> get copyWith => __$DemandesAffectationCopyWithImpl<_DemandesAffectation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DemandesAffectationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DemandesAffectation&&(identical(other.id, id) || other.id == id)&&(identical(other.dateDemande, dateDemande) || other.dateDemande == dateDemande)&&(identical(other.justification, justification) || other.justification == justification)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.motifRefus, motifRefus) || other.motifRefus == motifRefus)&&(identical(other.serviceBeneficiaire, serviceBeneficiaire) || other.serviceBeneficiaire == serviceBeneficiaire)&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.idDemandeur, idDemandeur) || other.idDemandeur == idDemandeur)&&(identical(other.idValideur, idValideur) || other.idValideur == idValideur)&&(identical(other.idCategorie, idCategorie) || other.idCategorie == idCategorie)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateDemande,justification,etat,motifRefus,serviceBeneficiaire,dateDebut,dateFinPrevue,idDemandeur,idValideur,idCategorie,createdAt);

@override
String toString() {
  return 'DemandesAffectation(id: $id, dateDemande: $dateDemande, justification: $justification, etat: $etat, motifRefus: $motifRefus, serviceBeneficiaire: $serviceBeneficiaire, dateDebut: $dateDebut, dateFinPrevue: $dateFinPrevue, idDemandeur: $idDemandeur, idValideur: $idValideur, idCategorie: $idCategorie, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DemandesAffectationCopyWith<$Res> implements $DemandesAffectationCopyWith<$Res> {
  factory _$DemandesAffectationCopyWith(_DemandesAffectation value, $Res Function(_DemandesAffectation) _then) = __$DemandesAffectationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_demande') String id,@JsonKey(name: 'date_demande') DateTime? dateDemande,@JsonKey(name: 'justification') String justification,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'motif_refus') String? motifRefus,@JsonKey(name: 'service_beneficiaire') String serviceBeneficiaire,@JsonKey(name: 'date_debut') DateTime? dateDebut,@JsonKey(name: 'date_fin_prevue') DateTime? dateFinPrevue,@JsonKey(name: 'id_demandeur') String idDemandeur,@JsonKey(name: 'id_valideur') String? idValideur,@JsonKey(name: 'id_categorie') String idCategorie,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$DemandesAffectationCopyWithImpl<$Res>
    implements _$DemandesAffectationCopyWith<$Res> {
  __$DemandesAffectationCopyWithImpl(this._self, this._then);

  final _DemandesAffectation _self;
  final $Res Function(_DemandesAffectation) _then;

/// Create a copy of DemandesAffectation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dateDemande = freezed,Object? justification = null,Object? etat = null,Object? motifRefus = freezed,Object? serviceBeneficiaire = null,Object? dateDebut = freezed,Object? dateFinPrevue = freezed,Object? idDemandeur = null,Object? idValideur = freezed,Object? idCategorie = null,Object? createdAt = freezed,}) {
  return _then(_DemandesAffectation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateDemande: freezed == dateDemande ? _self.dateDemande : dateDemande // ignore: cast_nullable_to_non_nullable
as DateTime?,justification: null == justification ? _self.justification : justification // ignore: cast_nullable_to_non_nullable
as String,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,motifRefus: freezed == motifRefus ? _self.motifRefus : motifRefus // ignore: cast_nullable_to_non_nullable
as String?,serviceBeneficiaire: null == serviceBeneficiaire ? _self.serviceBeneficiaire : serviceBeneficiaire // ignore: cast_nullable_to_non_nullable
as String,dateDebut: freezed == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as DateTime?,dateFinPrevue: freezed == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime?,idDemandeur: null == idDemandeur ? _self.idDemandeur : idDemandeur // ignore: cast_nullable_to_non_nullable
as String,idValideur: freezed == idValideur ? _self.idValideur : idValideur // ignore: cast_nullable_to_non_nullable
as String?,idCategorie: null == idCategorie ? _self.idCategorie : idCategorie // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
