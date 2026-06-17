// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gerer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Gerer {

@JsonKey(name: 'id_utilisateur') String get idUtilisateur;@JsonKey(name: 'id_zone') String get idZone;
/// Create a copy of Gerer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GererCopyWith<Gerer> get copyWith => _$GererCopyWithImpl<Gerer>(this as Gerer, _$identity);

  /// Serializes this Gerer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Gerer&&(identical(other.idUtilisateur, idUtilisateur) || other.idUtilisateur == idUtilisateur)&&(identical(other.idZone, idZone) || other.idZone == idZone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUtilisateur,idZone);

@override
String toString() {
  return 'Gerer(idUtilisateur: $idUtilisateur, idZone: $idZone)';
}


}

/// @nodoc
abstract mixin class $GererCopyWith<$Res>  {
  factory $GererCopyWith(Gerer value, $Res Function(Gerer) _then) = _$GererCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_utilisateur') String idUtilisateur,@JsonKey(name: 'id_zone') String idZone
});




}
/// @nodoc
class _$GererCopyWithImpl<$Res>
    implements $GererCopyWith<$Res> {
  _$GererCopyWithImpl(this._self, this._then);

  final Gerer _self;
  final $Res Function(Gerer) _then;

/// Create a copy of Gerer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idUtilisateur = null,Object? idZone = null,}) {
  return _then(_self.copyWith(
idUtilisateur: null == idUtilisateur ? _self.idUtilisateur : idUtilisateur // ignore: cast_nullable_to_non_nullable
as String,idZone: null == idZone ? _self.idZone : idZone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Gerer].
extension GererPatterns on Gerer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Gerer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Gerer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Gerer value)  $default,){
final _that = this;
switch (_that) {
case _Gerer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Gerer value)?  $default,){
final _that = this;
switch (_that) {
case _Gerer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'id_zone')  String idZone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Gerer() when $default != null:
return $default(_that.idUtilisateur,_that.idZone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'id_zone')  String idZone)  $default,) {final _that = this;
switch (_that) {
case _Gerer():
return $default(_that.idUtilisateur,_that.idZone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'id_zone')  String idZone)?  $default,) {final _that = this;
switch (_that) {
case _Gerer() when $default != null:
return $default(_that.idUtilisateur,_that.idZone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Gerer implements Gerer {
  const _Gerer({@JsonKey(name: 'id_utilisateur') required this.idUtilisateur, @JsonKey(name: 'id_zone') required this.idZone});
  factory _Gerer.fromJson(Map<String, dynamic> json) => _$GererFromJson(json);

@override@JsonKey(name: 'id_utilisateur') final  String idUtilisateur;
@override@JsonKey(name: 'id_zone') final  String idZone;

/// Create a copy of Gerer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GererCopyWith<_Gerer> get copyWith => __$GererCopyWithImpl<_Gerer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GererToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Gerer&&(identical(other.idUtilisateur, idUtilisateur) || other.idUtilisateur == idUtilisateur)&&(identical(other.idZone, idZone) || other.idZone == idZone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idUtilisateur,idZone);

@override
String toString() {
  return 'Gerer(idUtilisateur: $idUtilisateur, idZone: $idZone)';
}


}

/// @nodoc
abstract mixin class _$GererCopyWith<$Res> implements $GererCopyWith<$Res> {
  factory _$GererCopyWith(_Gerer value, $Res Function(_Gerer) _then) = __$GererCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_utilisateur') String idUtilisateur,@JsonKey(name: 'id_zone') String idZone
});




}
/// @nodoc
class __$GererCopyWithImpl<$Res>
    implements _$GererCopyWith<$Res> {
  __$GererCopyWithImpl(this._self, this._then);

  final _Gerer _self;
  final $Res Function(_Gerer) _then;

/// Create a copy of Gerer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idUtilisateur = null,Object? idZone = null,}) {
  return _then(_Gerer(
idUtilisateur: null == idUtilisateur ? _self.idUtilisateur : idUtilisateur // ignore: cast_nullable_to_non_nullable
as String,idZone: null == idZone ? _self.idZone : idZone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
