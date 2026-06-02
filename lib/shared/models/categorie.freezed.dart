// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categorie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Categorie {

 String get id_categorie; String get nom; String? get description; DateTime? get created_at;
/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorieCopyWith<Categorie> get copyWith => _$CategorieCopyWithImpl<Categorie>(this as Categorie, _$identity);

  /// Serializes this Categorie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Categorie&&(identical(other.id_categorie, id_categorie) || other.id_categorie == id_categorie)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_categorie,nom,description,created_at);

@override
String toString() {
  return 'Categorie(id_categorie: $id_categorie, nom: $nom, description: $description, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class $CategorieCopyWith<$Res>  {
  factory $CategorieCopyWith(Categorie value, $Res Function(Categorie) _then) = _$CategorieCopyWithImpl;
@useResult
$Res call({
 String id_categorie, String nom, String? description, DateTime? created_at
});




}
/// @nodoc
class _$CategorieCopyWithImpl<$Res>
    implements $CategorieCopyWith<$Res> {
  _$CategorieCopyWithImpl(this._self, this._then);

  final Categorie _self;
  final $Res Function(Categorie) _then;

/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id_categorie = null,Object? nom = null,Object? description = freezed,Object? created_at = freezed,}) {
  return _then(_self.copyWith(
id_categorie: null == id_categorie ? _self.id_categorie : id_categorie // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Categorie].
extension CategoriePatterns on Categorie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Categorie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Categorie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Categorie value)  $default,){
final _that = this;
switch (_that) {
case _Categorie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Categorie value)?  $default,){
final _that = this;
switch (_that) {
case _Categorie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id_categorie,  String nom,  String? description,  DateTime? created_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id_categorie,_that.nom,_that.description,_that.created_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id_categorie,  String nom,  String? description,  DateTime? created_at)  $default,) {final _that = this;
switch (_that) {
case _Categorie():
return $default(_that.id_categorie,_that.nom,_that.description,_that.created_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id_categorie,  String nom,  String? description,  DateTime? created_at)?  $default,) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id_categorie,_that.nom,_that.description,_that.created_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Categorie implements Categorie {
  const _Categorie({required this.id_categorie, required this.nom, this.description, this.created_at});
  factory _Categorie.fromJson(Map<String, dynamic> json) => _$CategorieFromJson(json);

@override final  String id_categorie;
@override final  String nom;
@override final  String? description;
@override final  DateTime? created_at;

/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorieCopyWith<_Categorie> get copyWith => __$CategorieCopyWithImpl<_Categorie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Categorie&&(identical(other.id_categorie, id_categorie) || other.id_categorie == id_categorie)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_categorie,nom,description,created_at);

@override
String toString() {
  return 'Categorie(id_categorie: $id_categorie, nom: $nom, description: $description, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class _$CategorieCopyWith<$Res> implements $CategorieCopyWith<$Res> {
  factory _$CategorieCopyWith(_Categorie value, $Res Function(_Categorie) _then) = __$CategorieCopyWithImpl;
@override @useResult
$Res call({
 String id_categorie, String nom, String? description, DateTime? created_at
});




}
/// @nodoc
class __$CategorieCopyWithImpl<$Res>
    implements _$CategorieCopyWith<$Res> {
  __$CategorieCopyWithImpl(this._self, this._then);

  final _Categorie _self;
  final $Res Function(_Categorie) _then;

/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id_categorie = null,Object? nom = null,Object? description = freezed,Object? created_at = freezed,}) {
  return _then(_Categorie(
id_categorie: null == id_categorie ? _self.id_categorie : id_categorie // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
