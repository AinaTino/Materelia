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

@JsonKey(name: 'id_materiel') String get id;@JsonKey(name: 'nom') String get nom;@JsonKey(name: 'reference') String get reference;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'etat') String get etat;@JsonKey(name: 'date_acquisition') String get dateAcquisition;@JsonKey(name: 'id_categorie') String get idCategorie;@JsonKey(name: 'id_stock') String get idStock;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Materiel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterielCopyWith<Materiel> get copyWith => _$MaterielCopyWithImpl<Materiel>(this as Materiel, _$identity);

  /// Serializes this Materiel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Materiel&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.dateAcquisition, dateAcquisition) || other.dateAcquisition == dateAcquisition)&&(identical(other.idCategorie, idCategorie) || other.idCategorie == idCategorie)&&(identical(other.idStock, idStock) || other.idStock == idStock)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,reference,description,etat,dateAcquisition,idCategorie,idStock,createdAt);

@override
String toString() {
  return 'Materiel(id: $id, nom: $nom, reference: $reference, description: $description, etat: $etat, dateAcquisition: $dateAcquisition, idCategorie: $idCategorie, idStock: $idStock, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MaterielCopyWith<$Res>  {
  factory $MaterielCopyWith(Materiel value, $Res Function(Materiel) _then) = _$MaterielCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_materiel') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'reference') String reference,@JsonKey(name: 'description') String? description,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'date_acquisition') String dateAcquisition,@JsonKey(name: 'id_categorie') String idCategorie,@JsonKey(name: 'id_stock') String idStock,@JsonKey(name: 'created_at') DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? reference = null,Object? description = freezed,Object? etat = null,Object? dateAcquisition = null,Object? idCategorie = null,Object? idStock = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,dateAcquisition: null == dateAcquisition ? _self.dateAcquisition : dateAcquisition // ignore: cast_nullable_to_non_nullable
as String,idCategorie: null == idCategorie ? _self.idCategorie : idCategorie // ignore: cast_nullable_to_non_nullable
as String,idStock: null == idStock ? _self.idStock : idStock // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_materiel')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'reference')  String reference, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'date_acquisition')  String dateAcquisition, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'id_stock')  String idStock, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Materiel() when $default != null:
return $default(_that.id,_that.nom,_that.reference,_that.description,_that.etat,_that.dateAcquisition,_that.idCategorie,_that.idStock,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_materiel')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'reference')  String reference, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'date_acquisition')  String dateAcquisition, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'id_stock')  String idStock, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Materiel():
return $default(_that.id,_that.nom,_that.reference,_that.description,_that.etat,_that.dateAcquisition,_that.idCategorie,_that.idStock,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_materiel')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'reference')  String reference, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'date_acquisition')  String dateAcquisition, @JsonKey(name: 'id_categorie')  String idCategorie, @JsonKey(name: 'id_stock')  String idStock, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Materiel() when $default != null:
return $default(_that.id,_that.nom,_that.reference,_that.description,_that.etat,_that.dateAcquisition,_that.idCategorie,_that.idStock,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Materiel implements Materiel {
  const _Materiel({@JsonKey(name: 'id_materiel') required this.id, @JsonKey(name: 'nom') required this.nom, @JsonKey(name: 'reference') required this.reference, @JsonKey(name: 'description') this.description, @JsonKey(name: 'etat') required this.etat, @JsonKey(name: 'date_acquisition') required this.dateAcquisition, @JsonKey(name: 'id_categorie') required this.idCategorie, @JsonKey(name: 'id_stock') required this.idStock, @JsonKey(name: 'created_at') this.createdAt});
  factory _Materiel.fromJson(Map<String, dynamic> json) => _$MaterielFromJson(json);

@override@JsonKey(name: 'id_materiel') final  String id;
@override@JsonKey(name: 'nom') final  String nom;
@override@JsonKey(name: 'reference') final  String reference;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'etat') final  String etat;
@override@JsonKey(name: 'date_acquisition') final  String dateAcquisition;
@override@JsonKey(name: 'id_categorie') final  String idCategorie;
@override@JsonKey(name: 'id_stock') final  String idStock;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Materiel&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.dateAcquisition, dateAcquisition) || other.dateAcquisition == dateAcquisition)&&(identical(other.idCategorie, idCategorie) || other.idCategorie == idCategorie)&&(identical(other.idStock, idStock) || other.idStock == idStock)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,reference,description,etat,dateAcquisition,idCategorie,idStock,createdAt);

@override
String toString() {
  return 'Materiel(id: $id, nom: $nom, reference: $reference, description: $description, etat: $etat, dateAcquisition: $dateAcquisition, idCategorie: $idCategorie, idStock: $idStock, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MaterielCopyWith<$Res> implements $MaterielCopyWith<$Res> {
  factory _$MaterielCopyWith(_Materiel value, $Res Function(_Materiel) _then) = __$MaterielCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_materiel') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'reference') String reference,@JsonKey(name: 'description') String? description,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'date_acquisition') String dateAcquisition,@JsonKey(name: 'id_categorie') String idCategorie,@JsonKey(name: 'id_stock') String idStock,@JsonKey(name: 'created_at') DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? reference = null,Object? description = freezed,Object? etat = null,Object? dateAcquisition = null,Object? idCategorie = null,Object? idStock = null,Object? createdAt = freezed,}) {
  return _then(_Materiel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,dateAcquisition: null == dateAcquisition ? _self.dateAcquisition : dateAcquisition // ignore: cast_nullable_to_non_nullable
as String,idCategorie: null == idCategorie ? _self.idCategorie : idCategorie // ignore: cast_nullable_to_non_nullable
as String,idStock: null == idStock ? _self.idStock : idStock // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
