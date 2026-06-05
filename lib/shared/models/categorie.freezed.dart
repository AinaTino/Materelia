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

@JsonKey(name: 'id_categorie') String get id;@JsonKey(name: 'nom') String get nom;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Categorie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorieCopyWith<Categorie> get copyWith => _$CategorieCopyWithImpl<Categorie>(this as Categorie, _$identity);

  /// Serializes this Categorie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Categorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,createdAt);

@override
String toString() {
  return 'Categorie(id: $id, nom: $nom, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CategorieCopyWith<$Res>  {
  factory $CategorieCopyWith(Categorie value, $Res Function(Categorie) _then) = _$CategorieCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_categorie') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'description') String? description,@JsonKey(name: 'created_at') DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_categorie')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_categorie')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Categorie():
return $default(_that.id,_that.nom,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_categorie')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Categorie() when $default != null:
return $default(_that.id,_that.nom,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Categorie implements Categorie {
  const _Categorie({@JsonKey(name: 'id_categorie') required this.id, @JsonKey(name: 'nom') required this.nom, @JsonKey(name: 'description') this.description, @JsonKey(name: 'created_at') this.createdAt});
  factory _Categorie.fromJson(Map<String, dynamic> json) => _$CategorieFromJson(json);

@override@JsonKey(name: 'id_categorie') final  String id;
@override@JsonKey(name: 'nom') final  String nom;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Categorie&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,description,createdAt);

@override
String toString() {
  return 'Categorie(id: $id, nom: $nom, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CategorieCopyWith<$Res> implements $CategorieCopyWith<$Res> {
  factory _$CategorieCopyWith(_Categorie value, $Res Function(_Categorie) _then) = __$CategorieCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_categorie') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'description') String? description,@JsonKey(name: 'created_at') DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? description = freezed,Object? createdAt = freezed,}) {
  return _then(_Categorie(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
