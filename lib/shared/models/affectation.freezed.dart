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

 String get id_affectation; DateTime get date_debut; DateTime get date_fin_prevue; DateTime? get date_fin_effective; String get etat; String get id_materiel; String get id_beneficiaire; String get id_demande; DateTime get date_fin;
/// Create a copy of Affectation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AffectationCopyWith<Affectation> get copyWith => _$AffectationCopyWithImpl<Affectation>(this as Affectation, _$identity);

  /// Serializes this Affectation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Affectation&&(identical(other.id_affectation, id_affectation) || other.id_affectation == id_affectation)&&(identical(other.date_debut, date_debut) || other.date_debut == date_debut)&&(identical(other.date_fin_prevue, date_fin_prevue) || other.date_fin_prevue == date_fin_prevue)&&(identical(other.date_fin_effective, date_fin_effective) || other.date_fin_effective == date_fin_effective)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.id_materiel, id_materiel) || other.id_materiel == id_materiel)&&(identical(other.id_beneficiaire, id_beneficiaire) || other.id_beneficiaire == id_beneficiaire)&&(identical(other.id_demande, id_demande) || other.id_demande == id_demande)&&(identical(other.date_fin, date_fin) || other.date_fin == date_fin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_affectation,date_debut,date_fin_prevue,date_fin_effective,etat,id_materiel,id_beneficiaire,id_demande,date_fin);

@override
String toString() {
  return 'Affectation(id_affectation: $id_affectation, date_debut: $date_debut, date_fin_prevue: $date_fin_prevue, date_fin_effective: $date_fin_effective, etat: $etat, id_materiel: $id_materiel, id_beneficiaire: $id_beneficiaire, id_demande: $id_demande, date_fin: $date_fin)';
}


}

/// @nodoc
abstract mixin class $AffectationCopyWith<$Res>  {
  factory $AffectationCopyWith(Affectation value, $Res Function(Affectation) _then) = _$AffectationCopyWithImpl;
@useResult
$Res call({
 String id_affectation, DateTime date_debut, DateTime date_fin_prevue, DateTime? date_fin_effective, String etat, String id_materiel, String id_beneficiaire, String id_demande, DateTime date_fin
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
@pragma('vm:prefer-inline') @override $Res call({Object? id_affectation = null,Object? date_debut = null,Object? date_fin_prevue = null,Object? date_fin_effective = freezed,Object? etat = null,Object? id_materiel = null,Object? id_beneficiaire = null,Object? id_demande = null,Object? date_fin = null,}) {
  return _then(_self.copyWith(
id_affectation: null == id_affectation ? _self.id_affectation : id_affectation // ignore: cast_nullable_to_non_nullable
as String,date_debut: null == date_debut ? _self.date_debut : date_debut // ignore: cast_nullable_to_non_nullable
as DateTime,date_fin_prevue: null == date_fin_prevue ? _self.date_fin_prevue : date_fin_prevue // ignore: cast_nullable_to_non_nullable
as DateTime,date_fin_effective: freezed == date_fin_effective ? _self.date_fin_effective : date_fin_effective // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,id_materiel: null == id_materiel ? _self.id_materiel : id_materiel // ignore: cast_nullable_to_non_nullable
as String,id_beneficiaire: null == id_beneficiaire ? _self.id_beneficiaire : id_beneficiaire // ignore: cast_nullable_to_non_nullable
as String,id_demande: null == id_demande ? _self.id_demande : id_demande // ignore: cast_nullable_to_non_nullable
as String,date_fin: null == date_fin ? _self.date_fin : date_fin // ignore: cast_nullable_to_non_nullable
as DateTime,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id_affectation,  DateTime date_debut,  DateTime date_fin_prevue,  DateTime? date_fin_effective,  String etat,  String id_materiel,  String id_beneficiaire,  String id_demande,  DateTime date_fin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Affectation() when $default != null:
return $default(_that.id_affectation,_that.date_debut,_that.date_fin_prevue,_that.date_fin_effective,_that.etat,_that.id_materiel,_that.id_beneficiaire,_that.id_demande,_that.date_fin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id_affectation,  DateTime date_debut,  DateTime date_fin_prevue,  DateTime? date_fin_effective,  String etat,  String id_materiel,  String id_beneficiaire,  String id_demande,  DateTime date_fin)  $default,) {final _that = this;
switch (_that) {
case _Affectation():
return $default(_that.id_affectation,_that.date_debut,_that.date_fin_prevue,_that.date_fin_effective,_that.etat,_that.id_materiel,_that.id_beneficiaire,_that.id_demande,_that.date_fin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id_affectation,  DateTime date_debut,  DateTime date_fin_prevue,  DateTime? date_fin_effective,  String etat,  String id_materiel,  String id_beneficiaire,  String id_demande,  DateTime date_fin)?  $default,) {final _that = this;
switch (_that) {
case _Affectation() when $default != null:
return $default(_that.id_affectation,_that.date_debut,_that.date_fin_prevue,_that.date_fin_effective,_that.etat,_that.id_materiel,_that.id_beneficiaire,_that.id_demande,_that.date_fin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Affectation implements Affectation {
  const _Affectation({required this.id_affectation, required this.date_debut, required this.date_fin_prevue, this.date_fin_effective, required this.etat, required this.id_materiel, required this.id_beneficiaire, required this.id_demande, required this.date_fin});
  factory _Affectation.fromJson(Map<String, dynamic> json) => _$AffectationFromJson(json);

@override final  String id_affectation;
@override final  DateTime date_debut;
@override final  DateTime date_fin_prevue;
@override final  DateTime? date_fin_effective;
@override final  String etat;
@override final  String id_materiel;
@override final  String id_beneficiaire;
@override final  String id_demande;
@override final  DateTime date_fin;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Affectation&&(identical(other.id_affectation, id_affectation) || other.id_affectation == id_affectation)&&(identical(other.date_debut, date_debut) || other.date_debut == date_debut)&&(identical(other.date_fin_prevue, date_fin_prevue) || other.date_fin_prevue == date_fin_prevue)&&(identical(other.date_fin_effective, date_fin_effective) || other.date_fin_effective == date_fin_effective)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.id_materiel, id_materiel) || other.id_materiel == id_materiel)&&(identical(other.id_beneficiaire, id_beneficiaire) || other.id_beneficiaire == id_beneficiaire)&&(identical(other.id_demande, id_demande) || other.id_demande == id_demande)&&(identical(other.date_fin, date_fin) || other.date_fin == date_fin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_affectation,date_debut,date_fin_prevue,date_fin_effective,etat,id_materiel,id_beneficiaire,id_demande,date_fin);

@override
String toString() {
  return 'Affectation(id_affectation: $id_affectation, date_debut: $date_debut, date_fin_prevue: $date_fin_prevue, date_fin_effective: $date_fin_effective, etat: $etat, id_materiel: $id_materiel, id_beneficiaire: $id_beneficiaire, id_demande: $id_demande, date_fin: $date_fin)';
}


}

/// @nodoc
abstract mixin class _$AffectationCopyWith<$Res> implements $AffectationCopyWith<$Res> {
  factory _$AffectationCopyWith(_Affectation value, $Res Function(_Affectation) _then) = __$AffectationCopyWithImpl;
@override @useResult
$Res call({
 String id_affectation, DateTime date_debut, DateTime date_fin_prevue, DateTime? date_fin_effective, String etat, String id_materiel, String id_beneficiaire, String id_demande, DateTime date_fin
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
@override @pragma('vm:prefer-inline') $Res call({Object? id_affectation = null,Object? date_debut = null,Object? date_fin_prevue = null,Object? date_fin_effective = freezed,Object? etat = null,Object? id_materiel = null,Object? id_beneficiaire = null,Object? id_demande = null,Object? date_fin = null,}) {
  return _then(_Affectation(
id_affectation: null == id_affectation ? _self.id_affectation : id_affectation // ignore: cast_nullable_to_non_nullable
as String,date_debut: null == date_debut ? _self.date_debut : date_debut // ignore: cast_nullable_to_non_nullable
as DateTime,date_fin_prevue: null == date_fin_prevue ? _self.date_fin_prevue : date_fin_prevue // ignore: cast_nullable_to_non_nullable
as DateTime,date_fin_effective: freezed == date_fin_effective ? _self.date_fin_effective : date_fin_effective // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,id_materiel: null == id_materiel ? _self.id_materiel : id_materiel // ignore: cast_nullable_to_non_nullable
as String,id_beneficiaire: null == id_beneficiaire ? _self.id_beneficiaire : id_beneficiaire // ignore: cast_nullable_to_non_nullable
as String,id_demande: null == id_demande ? _self.id_demande : id_demande // ignore: cast_nullable_to_non_nullable
as String,date_fin: null == date_fin ? _self.date_fin : date_fin // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
