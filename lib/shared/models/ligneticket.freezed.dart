// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ligneticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LigneTicket {

@JsonKey(name: 'id_ligne_ticket') String get id;@JsonKey(name: 'id_ticket') String get idTicket;@JsonKey(name: 'id_materiel') String get idMateriel;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of LigneTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LigneTicketCopyWith<LigneTicket> get copyWith => _$LigneTicketCopyWithImpl<LigneTicket>(this as LigneTicket, _$identity);

  /// Serializes this LigneTicket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LigneTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.idTicket, idTicket) || other.idTicket == idTicket)&&(identical(other.idMateriel, idMateriel) || other.idMateriel == idMateriel)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idTicket,idMateriel,createdAt);

@override
String toString() {
  return 'LigneTicket(id: $id, idTicket: $idTicket, idMateriel: $idMateriel, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LigneTicketCopyWith<$Res>  {
  factory $LigneTicketCopyWith(LigneTicket value, $Res Function(LigneTicket) _then) = _$LigneTicketCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_ligne_ticket') String id,@JsonKey(name: 'id_ticket') String idTicket,@JsonKey(name: 'id_materiel') String idMateriel,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$LigneTicketCopyWithImpl<$Res>
    implements $LigneTicketCopyWith<$Res> {
  _$LigneTicketCopyWithImpl(this._self, this._then);

  final LigneTicket _self;
  final $Res Function(LigneTicket) _then;

/// Create a copy of LigneTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? idTicket = null,Object? idMateriel = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,idTicket: null == idTicket ? _self.idTicket : idTicket // ignore: cast_nullable_to_non_nullable
as String,idMateriel: null == idMateriel ? _self.idMateriel : idMateriel // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LigneTicket].
extension LigneTicketPatterns on LigneTicket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LigneTicket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LigneTicket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LigneTicket value)  $default,){
final _that = this;
switch (_that) {
case _LigneTicket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LigneTicket value)?  $default,){
final _that = this;
switch (_that) {
case _LigneTicket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_ligne_ticket')  String id, @JsonKey(name: 'id_ticket')  String idTicket, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LigneTicket() when $default != null:
return $default(_that.id,_that.idTicket,_that.idMateriel,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_ligne_ticket')  String id, @JsonKey(name: 'id_ticket')  String idTicket, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _LigneTicket():
return $default(_that.id,_that.idTicket,_that.idMateriel,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_ligne_ticket')  String id, @JsonKey(name: 'id_ticket')  String idTicket, @JsonKey(name: 'id_materiel')  String idMateriel, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LigneTicket() when $default != null:
return $default(_that.id,_that.idTicket,_that.idMateriel,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LigneTicket implements LigneTicket {
  const _LigneTicket({@JsonKey(name: 'id_ligne_ticket') required this.id, @JsonKey(name: 'id_ticket') required this.idTicket, @JsonKey(name: 'id_materiel') required this.idMateriel, @JsonKey(name: 'created_at') this.createdAt});
  factory _LigneTicket.fromJson(Map<String, dynamic> json) => _$LigneTicketFromJson(json);

@override@JsonKey(name: 'id_ligne_ticket') final  String id;
@override@JsonKey(name: 'id_ticket') final  String idTicket;
@override@JsonKey(name: 'id_materiel') final  String idMateriel;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of LigneTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LigneTicketCopyWith<_LigneTicket> get copyWith => __$LigneTicketCopyWithImpl<_LigneTicket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LigneTicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LigneTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.idTicket, idTicket) || other.idTicket == idTicket)&&(identical(other.idMateriel, idMateriel) || other.idMateriel == idMateriel)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idTicket,idMateriel,createdAt);

@override
String toString() {
  return 'LigneTicket(id: $id, idTicket: $idTicket, idMateriel: $idMateriel, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LigneTicketCopyWith<$Res> implements $LigneTicketCopyWith<$Res> {
  factory _$LigneTicketCopyWith(_LigneTicket value, $Res Function(_LigneTicket) _then) = __$LigneTicketCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_ligne_ticket') String id,@JsonKey(name: 'id_ticket') String idTicket,@JsonKey(name: 'id_materiel') String idMateriel,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$LigneTicketCopyWithImpl<$Res>
    implements _$LigneTicketCopyWith<$Res> {
  __$LigneTicketCopyWithImpl(this._self, this._then);

  final _LigneTicket _self;
  final $Res Function(_LigneTicket) _then;

/// Create a copy of LigneTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? idTicket = null,Object? idMateriel = null,Object? createdAt = freezed,}) {
  return _then(_LigneTicket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,idTicket: null == idTicket ? _self.idTicket : idTicket // ignore: cast_nullable_to_non_nullable
as String,idMateriel: null == idMateriel ? _self.idMateriel : idMateriel // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
