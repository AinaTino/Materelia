// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'affectation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Affectation {

@JsonKey(name: 'id_affectation') String get id;@JsonKey(name: 'date_debut') DateTime get dateDebut;@JsonKey(name: 'date_fin_prevue') DateTime get dateFinPrevue;@JsonKey(name: 'date_fin_effective') DateTime? get dateFinEffective;@JsonKey(name: 'etat') String get etat;@JsonKey(name: 'id_materiel') String get idMateriel;@JsonKey(name: 'id_beneficiaire') String get idBeneficiaire;@JsonKey(name: 'id_demande') String get idDemande;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Affectation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AffectationCopyWith<Affectation> get copyWith => _$AffectationCopyWithImpl<Affectation>(this as Affectation, _$identity);

  /// Serializes this Affectation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Affectation&&(identical(other.id, id) || other.id == id)&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.dateFinEffective, dateFinEffective) || other.dateFinEffective == dateFinEffective)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.idMateriel, idMateriel) || other.idMateriel == idMateriel)&&(identical(other.idBeneficiaire, idBeneficiaire) || other.idBeneficiaire == idBeneficiaire)&&(identical(other.idDemande, idDemande) || other.idDemande == idDemande)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateDebut,dateFinPrevue,dateFinEffective,etat,idMateriel,idBeneficiaire,idDemande,createdAt);

@override
String toString() {
  return 'Affectation(id: $id, dateDebut: $dateDebut, dateFinPrevue: $dateFinPrevue, dateFinEffective: $dateFinEffective, etat: $etat, idMateriel: $idMateriel, idBeneficiaire: $idBeneficiaire, idDemande: $idDemande, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AffectationCopyWith<$Res>  {
  factory $AffectationCopyWith(Affectation value, $Res Function(Affectation) _then) = _$AffectationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_affectation') String id,@JsonKey(name: 'date_debut') DateTime dateDebut,@JsonKey(name: 'date_fin_prevue') DateTime dateFinPrevue,@JsonKey(name: 'date_fin_effective') DateTime? dateFinEffective,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'id_materiel') String idMateriel,@JsonKey(name: 'id_beneficiaire') String idBeneficiaire,@JsonKey(name: 'id_demande') String idDemande,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$AffectationCopyWithImpl<$Res>
    implements $AffectationCopyWith<$Res> {
  _$AffectationCopyWithImpl(this._self, this._then);

  final Affectation _self;
  final $Res Function(Affectation) _then;

/// Create a copy of Affectation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dateDebut = null,Object? dateFinPrevue = null,Object? dateFinEffective = freezed,Object? etat = null,Object? idMateriel = null,Object? idBeneficiaire = null,Object? idDemande = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateDebut: null == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as DateTime,dateFinPrevue: null == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime,dateFinEffective: freezed == dateFinEffective ? _self.dateFinEffective : dateFinEffective // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,idMateriel: null == idMateriel ? _self.idMateriel : idMateriel // ignore: cast_nullable_to_non_nullable
as String,idBeneficiaire: null == idBeneficiaire ? _self.idBeneficiaire : idBeneficiaire // ignore: cast_nullable_to_non_nullable
as String,idDemande: null == idDemande ? _self.idDemande : idDemande // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Affectation].
extension AffectationPatterns on Affectation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Affectation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Affectation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Affectation value)  $default,){
final _that = this;
switch (_that) {
case _Affectation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Affectation value)?  $default,){
final _that = this;
switch (_that) {
case _Affectation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_affectation')  String id, @JsonKey(name: 'date_debut')  DateTime dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_fin_effective')  DateTime? dateFinEffective, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'id_beneficiaire')  String idBeneficiaire, @JsonKey(name: 'id_demande')  String idDemande, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Affectation() when $default != null:
return $default(_that.id,_that.dateDebut,_that.dateFinPrevue,_that.dateFinEffective,_that.etat,_that.idMateriel,_that.idBeneficiaire,_that.idDemande,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_affectation')  String id, @JsonKey(name: 'date_debut')  DateTime dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_fin_effective')  DateTime? dateFinEffective, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'id_beneficiaire')  String idBeneficiaire, @JsonKey(name: 'id_demande')  String idDemande, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Affectation():
return $default(_that.id,_that.dateDebut,_that.dateFinPrevue,_that.dateFinEffective,_that.etat,_that.idMateriel,_that.idBeneficiaire,_that.idDemande,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_affectation')  String id, @JsonKey(name: 'date_debut')  DateTime dateDebut, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_fin_effective')  DateTime? dateFinEffective, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'id_beneficiaire')  String idBeneficiaire, @JsonKey(name: 'id_demande')  String idDemande, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Affectation() when $default != null:
return $default(_that.id,_that.dateDebut,_that.dateFinPrevue,_that.dateFinEffective,_that.etat,_that.idMateriel,_that.idBeneficiaire,_that.idDemande,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Affectation implements Affectation {
  const _Affectation({@JsonKey(name: 'id_affectation') required this.id, @JsonKey(name: 'date_debut') required this.dateDebut, @JsonKey(name: 'date_fin_prevue') required this.dateFinPrevue, @JsonKey(name: 'date_fin_effective') this.dateFinEffective, @JsonKey(name: 'etat') required this.etat, @JsonKey(name: 'id_materiel') required this.idMateriel, @JsonKey(name: 'id_beneficiaire') required this.idBeneficiaire, @JsonKey(name: 'id_demande') required this.idDemande, @JsonKey(name: 'created_at') this.createdAt});
  factory _Affectation.fromJson(Map<String, dynamic> json) => _$AffectationFromJson(json);

@override@JsonKey(name: 'id_affectation') final  String id;
@override@JsonKey(name: 'date_debut') final  DateTime dateDebut;
@override@JsonKey(name: 'date_fin_prevue') final  DateTime dateFinPrevue;
@override@JsonKey(name: 'date_fin_effective') final  DateTime? dateFinEffective;
@override@JsonKey(name: 'etat') final  String etat;
@override@JsonKey(name: 'id_materiel') final  String idMateriel;
@override@JsonKey(name: 'id_beneficiaire') final  String idBeneficiaire;
@override@JsonKey(name: 'id_demande') final  String idDemande;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Affectation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AffectationCopyWith<_Affectation> get copyWith => __$AffectationCopyWithImpl<_Affectation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AffectationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Affectation&&(identical(other.id, id) || other.id == id)&&(identical(other.dateDebut, dateDebut) || other.dateDebut == dateDebut)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.dateFinEffective, dateFinEffective) || other.dateFinEffective == dateFinEffective)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.idMateriel, idMateriel) || other.idMateriel == idMateriel)&&(identical(other.idBeneficiaire, idBeneficiaire) || other.idBeneficiaire == idBeneficiaire)&&(identical(other.idDemande, idDemande) || other.idDemande == idDemande)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateDebut,dateFinPrevue,dateFinEffective,etat,idMateriel,idBeneficiaire,idDemande,createdAt);

@override
String toString() {
  return 'Affectation(id: $id, dateDebut: $dateDebut, dateFinPrevue: $dateFinPrevue, dateFinEffective: $dateFinEffective, etat: $etat, idMateriel: $idMateriel, idBeneficiaire: $idBeneficiaire, idDemande: $idDemande, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AffectationCopyWith<$Res> implements $AffectationCopyWith<$Res> {
  factory _$AffectationCopyWith(_Affectation value, $Res Function(_Affectation) _then) = __$AffectationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_affectation') String id,@JsonKey(name: 'date_debut') DateTime dateDebut,@JsonKey(name: 'date_fin_prevue') DateTime dateFinPrevue,@JsonKey(name: 'date_fin_effective') DateTime? dateFinEffective,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'id_materiel') String idMateriel,@JsonKey(name: 'id_beneficiaire') String idBeneficiaire,@JsonKey(name: 'id_demande') String idDemande,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$AffectationCopyWithImpl<$Res>
    implements _$AffectationCopyWith<$Res> {
  __$AffectationCopyWithImpl(this._self, this._then);

  final _Affectation _self;
  final $Res Function(_Affectation) _then;

/// Create a copy of Affectation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dateDebut = null,Object? dateFinPrevue = null,Object? dateFinEffective = freezed,Object? etat = null,Object? idMateriel = null,Object? idBeneficiaire = null,Object? idDemande = null,Object? createdAt = freezed,}) {
  return _then(_Affectation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dateDebut: null == dateDebut ? _self.dateDebut : dateDebut // ignore: cast_nullable_to_non_nullable
as DateTime,dateFinPrevue: null == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime,dateFinEffective: freezed == dateFinEffective ? _self.dateFinEffective : dateFinEffective // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,idMateriel: null == idMateriel ? _self.idMateriel : idMateriel // ignore: cast_nullable_to_non_nullable
as String,idBeneficiaire: null == idBeneficiaire ? _self.idBeneficiaire : idBeneficiaire // ignore: cast_nullable_to_non_nullable
as String,idDemande: null == idDemande ? _self.idDemande : idDemande // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
