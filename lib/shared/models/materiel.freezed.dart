// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'materiel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Materiel {

 String get id_materiel; String get nom; String get reference; String? get description; String get etat; String get date_acquisition; String get id_categorie; String get id_stock; DateTime? get created_at;
/// Create a copy of Materiel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterielCopyWith<Materiel> get copyWith => _$MaterielCopyWithImpl<Materiel>(this as Materiel, _$identity);

  /// Serializes this Materiel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Materiel&&(identical(other.id_materiel, id_materiel) || other.id_materiel == id_materiel)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.date_acquisition, date_acquisition) || other.date_acquisition == date_acquisition)&&(identical(other.id_categorie, id_categorie) || other.id_categorie == id_categorie)&&(identical(other.id_stock, id_stock) || other.id_stock == id_stock)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_materiel,nom,reference,description,etat,date_acquisition,id_categorie,id_stock,created_at);

@override
String toString() {
  return 'Materiel(id_materiel: $id_materiel, nom: $nom, reference: $reference, description: $description, etat: $etat, date_acquisition: $date_acquisition, id_categorie: $id_categorie, id_stock: $id_stock, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class $MaterielCopyWith<$Res>  {
  factory $MaterielCopyWith(Materiel value, $Res Function(Materiel) _then) = _$MaterielCopyWithImpl;
@useResult
$Res call({
 String id_materiel, String nom, String reference, String? description, String etat, String date_acquisition, String id_categorie, String id_stock, DateTime? created_at
});




}
/// @nodoc
class _$MaterielCopyWithImpl<$Res>
    implements $MaterielCopyWith<$Res> {
  _$MaterielCopyWithImpl(this._self, this._then);

  final Materiel _self;
  final $Res Function(Materiel) _then;

/// Create a copy of Materiel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id_materiel = null,Object? nom = null,Object? reference = null,Object? description = freezed,Object? etat = null,Object? date_acquisition = null,Object? id_categorie = null,Object? id_stock = null,Object? created_at = freezed,}) {
  return _then(_self.copyWith(
id_materiel: null == id_materiel ? _self.id_materiel : id_materiel // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,date_acquisition: null == date_acquisition ? _self.date_acquisition : date_acquisition // ignore: cast_nullable_to_non_nullable
as String,id_categorie: null == id_categorie ? _self.id_categorie : id_categorie // ignore: cast_nullable_to_non_nullable
as String,id_stock: null == id_stock ? _self.id_stock : id_stock // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Materiel].
extension MaterielPatterns on Materiel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Materiel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Materiel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Materiel value)  $default,){
final _that = this;
switch (_that) {
case _Materiel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Materiel value)?  $default,){
final _that = this;
switch (_that) {
case _Materiel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id_materiel,  String nom,  String reference,  String? description,  String etat,  String date_acquisition,  String id_categorie,  String id_stock,  DateTime? created_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Materiel() when $default != null:
return $default(_that.id_materiel,_that.nom,_that.reference,_that.description,_that.etat,_that.date_acquisition,_that.id_categorie,_that.id_stock,_that.created_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id_materiel,  String nom,  String reference,  String? description,  String etat,  String date_acquisition,  String id_categorie,  String id_stock,  DateTime? created_at)  $default,) {final _that = this;
switch (_that) {
case _Materiel():
return $default(_that.id_materiel,_that.nom,_that.reference,_that.description,_that.etat,_that.date_acquisition,_that.id_categorie,_that.id_stock,_that.created_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id_materiel,  String nom,  String reference,  String? description,  String etat,  String date_acquisition,  String id_categorie,  String id_stock,  DateTime? created_at)?  $default,) {final _that = this;
switch (_that) {
case _Materiel() when $default != null:
return $default(_that.id_materiel,_that.nom,_that.reference,_that.description,_that.etat,_that.date_acquisition,_that.id_categorie,_that.id_stock,_that.created_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Materiel implements Materiel {
  const _Materiel({required this.id_materiel, required this.nom, required this.reference, this.description, required this.etat, required this.date_acquisition, required this.id_categorie, required this.id_stock, this.created_at});
  factory _Materiel.fromJson(Map<String, dynamic> json) => _$MaterielFromJson(json);

@override final  String id_materiel;
@override final  String nom;
@override final  String reference;
@override final  String? description;
@override final  String etat;
@override final  String date_acquisition;
@override final  String id_categorie;
@override final  String id_stock;
@override final  DateTime? created_at;

/// Create a copy of Materiel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaterielCopyWith<_Materiel> get copyWith => __$MaterielCopyWithImpl<_Materiel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterielToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Materiel&&(identical(other.id_materiel, id_materiel) || other.id_materiel == id_materiel)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.date_acquisition, date_acquisition) || other.date_acquisition == date_acquisition)&&(identical(other.id_categorie, id_categorie) || other.id_categorie == id_categorie)&&(identical(other.id_stock, id_stock) || other.id_stock == id_stock)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_materiel,nom,reference,description,etat,date_acquisition,id_categorie,id_stock,created_at);

@override
String toString() {
  return 'Materiel(id_materiel: $id_materiel, nom: $nom, reference: $reference, description: $description, etat: $etat, date_acquisition: $date_acquisition, id_categorie: $id_categorie, id_stock: $id_stock, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class _$MaterielCopyWith<$Res> implements $MaterielCopyWith<$Res> {
  factory _$MaterielCopyWith(_Materiel value, $Res Function(_Materiel) _then) = __$MaterielCopyWithImpl;
@override @useResult
$Res call({
 String id_materiel, String nom, String reference, String? description, String etat, String date_acquisition, String id_categorie, String id_stock, DateTime? created_at
});




}
/// @nodoc
class __$MaterielCopyWithImpl<$Res>
    implements _$MaterielCopyWith<$Res> {
  __$MaterielCopyWithImpl(this._self, this._then);

  final _Materiel _self;
  final $Res Function(_Materiel) _then;

/// Create a copy of Materiel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id_materiel = null,Object? nom = null,Object? reference = null,Object? description = freezed,Object? etat = null,Object? date_acquisition = null,Object? id_categorie = null,Object? id_stock = null,Object? created_at = freezed,}) {
  return _then(_Materiel(
id_materiel: null == id_materiel ? _self.id_materiel : id_materiel // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,date_acquisition: null == date_acquisition ? _self.date_acquisition : date_acquisition // ignore: cast_nullable_to_non_nullable
as String,id_categorie: null == id_categorie ? _self.id_categorie : id_categorie // ignore: cast_nullable_to_non_nullable
as String,id_stock: null == id_stock ? _self.id_stock : id_stock // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
