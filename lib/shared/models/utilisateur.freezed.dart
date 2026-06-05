// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'utilisateur.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Utilisateur {

@JsonKey(name: 'id_utilisateur') String get id;@JsonKey(name: 'nom') String get nom;@JsonKey(name: 'prenom') String get prenom;@JsonKey(name: 'role') String get role;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UtilisateurCopyWith<Utilisateur> get copyWith => _$UtilisateurCopyWithImpl<Utilisateur>(this as Utilisateur, _$identity);

  /// Serializes this Utilisateur to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Utilisateur&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prenom, prenom) || other.prenom == prenom)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prenom,role,createdAt);

@override
String toString() {
  return 'Utilisateur(id: $id, nom: $nom, prenom: $prenom, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UtilisateurCopyWith<$Res>  {
  factory $UtilisateurCopyWith(Utilisateur value, $Res Function(Utilisateur) _then) = _$UtilisateurCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_utilisateur') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'prenom') String prenom,@JsonKey(name: 'role') String role,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$UtilisateurCopyWithImpl<$Res>
    implements $UtilisateurCopyWith<$Res> {
  _$UtilisateurCopyWithImpl(this._self, this._then);

  final Utilisateur _self;
  final $Res Function(Utilisateur) _then;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nom = null,Object? prenom = null,Object? role = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prenom: null == prenom ? _self.prenom : prenom // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Utilisateur].
extension UtilisateurPatterns on Utilisateur {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Utilisateur value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Utilisateur value)  $default,){
final _that = this;
switch (_that) {
case _Utilisateur():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Utilisateur value)?  $default,){
final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_utilisateur')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'prenom')  String prenom, @JsonKey(name: 'role')  String role, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
return $default(_that.id,_that.nom,_that.prenom,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_utilisateur')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'prenom')  String prenom, @JsonKey(name: 'role')  String role, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Utilisateur():
return $default(_that.id,_that.nom,_that.prenom,_that.role,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_utilisateur')  String id, @JsonKey(name: 'nom')  String nom, @JsonKey(name: 'prenom')  String prenom, @JsonKey(name: 'role')  String role, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Utilisateur() when $default != null:
return $default(_that.id,_that.nom,_that.prenom,_that.role,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Utilisateur implements Utilisateur {
  const _Utilisateur({@JsonKey(name: 'id_utilisateur') required this.id, @JsonKey(name: 'nom') required this.nom, @JsonKey(name: 'prenom') required this.prenom, @JsonKey(name: 'role') required this.role, @JsonKey(name: 'created_at') this.createdAt});
  factory _Utilisateur.fromJson(Map<String, dynamic> json) => _$UtilisateurFromJson(json);

@override@JsonKey(name: 'id_utilisateur') final  String id;
@override@JsonKey(name: 'nom') final  String nom;
@override@JsonKey(name: 'prenom') final  String prenom;
@override@JsonKey(name: 'role') final  String role;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UtilisateurCopyWith<_Utilisateur> get copyWith => __$UtilisateurCopyWithImpl<_Utilisateur>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UtilisateurToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Utilisateur&&(identical(other.id, id) || other.id == id)&&(identical(other.nom, nom) || other.nom == nom)&&(identical(other.prenom, prenom) || other.prenom == prenom)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nom,prenom,role,createdAt);

@override
String toString() {
  return 'Utilisateur(id: $id, nom: $nom, prenom: $prenom, role: $role, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UtilisateurCopyWith<$Res> implements $UtilisateurCopyWith<$Res> {
  factory _$UtilisateurCopyWith(_Utilisateur value, $Res Function(_Utilisateur) _then) = __$UtilisateurCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_utilisateur') String id,@JsonKey(name: 'nom') String nom,@JsonKey(name: 'prenom') String prenom,@JsonKey(name: 'role') String role,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$UtilisateurCopyWithImpl<$Res>
    implements _$UtilisateurCopyWith<$Res> {
  __$UtilisateurCopyWithImpl(this._self, this._then);

  final _Utilisateur _self;
  final $Res Function(_Utilisateur) _then;

/// Create a copy of Utilisateur
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nom = null,Object? prenom = null,Object? role = null,Object? createdAt = freezed,}) {
  return _then(_Utilisateur(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nom: null == nom ? _self.nom : nom // ignore: cast_nullable_to_non_nullable
as String,prenom: null == prenom ? _self.prenom : prenom // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
