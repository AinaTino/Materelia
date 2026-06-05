// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Notification {

@JsonKey(name: 'id_notification') String get id;@JsonKey(name: 'message') String get message;@JsonKey(name: 'type') String get type;@JsonKey(name: 'date_envoi') DateTime? get date_envoi;@JsonKey(name: 'lu') bool? get lu;@JsonKey(name: 'id_utilisateur') String get idUtilisateur;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.date_envoi, date_envoi) || other.date_envoi == date_envoi)&&(identical(other.lu, lu) || other.lu == lu)&&(identical(other.idUtilisateur, idUtilisateur) || other.idUtilisateur == idUtilisateur)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,type,date_envoi,lu,idUtilisateur,createdAt);

@override
String toString() {
  return 'Notification(id: $id, message: $message, type: $type, date_envoi: $date_envoi, lu: $lu, idUtilisateur: $idUtilisateur, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_notification') String id,@JsonKey(name: 'message') String message,@JsonKey(name: 'type') String type,@JsonKey(name: 'date_envoi') DateTime? date_envoi,@JsonKey(name: 'lu') bool? lu,@JsonKey(name: 'id_utilisateur') String idUtilisateur,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = null,Object? type = null,Object? date_envoi = freezed,Object? lu = freezed,Object? idUtilisateur = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date_envoi: freezed == date_envoi ? _self.date_envoi : date_envoi // ignore: cast_nullable_to_non_nullable
as DateTime?,lu: freezed == lu ? _self.lu : lu // ignore: cast_nullable_to_non_nullable
as bool?,idUtilisateur: null == idUtilisateur ? _self.idUtilisateur : idUtilisateur // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notification value)  $default,){
final _that = this;
switch (_that) {
case _Notification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notification value)?  $default,){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_notification')  String id, @JsonKey(name: 'message')  String message, @JsonKey(name: 'type')  String type, @JsonKey(name: 'date_envoi')  DateTime? date_envoi, @JsonKey(name: 'lu')  bool? lu, @JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.message,_that.type,_that.date_envoi,_that.lu,_that.idUtilisateur,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_notification')  String id, @JsonKey(name: 'message')  String message, @JsonKey(name: 'type')  String type, @JsonKey(name: 'date_envoi')  DateTime? date_envoi, @JsonKey(name: 'lu')  bool? lu, @JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Notification():
return $default(_that.id,_that.message,_that.type,_that.date_envoi,_that.lu,_that.idUtilisateur,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_notification')  String id, @JsonKey(name: 'message')  String message, @JsonKey(name: 'type')  String type, @JsonKey(name: 'date_envoi')  DateTime? date_envoi, @JsonKey(name: 'lu')  bool? lu, @JsonKey(name: 'id_utilisateur')  String idUtilisateur, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.message,_that.type,_that.date_envoi,_that.lu,_that.idUtilisateur,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Notification implements Notification {
  const _Notification({@JsonKey(name: 'id_notification') required this.id, @JsonKey(name: 'message') required this.message, @JsonKey(name: 'type') required this.type, @JsonKey(name: 'date_envoi') this.date_envoi, @JsonKey(name: 'lu') this.lu, @JsonKey(name: 'id_utilisateur') required this.idUtilisateur, @JsonKey(name: 'created_at') this.createdAt});
  factory _Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

@override@JsonKey(name: 'id_notification') final  String id;
@override@JsonKey(name: 'message') final  String message;
@override@JsonKey(name: 'type') final  String type;
@override@JsonKey(name: 'date_envoi') final  DateTime? date_envoi;
@override@JsonKey(name: 'lu') final  bool? lu;
@override@JsonKey(name: 'id_utilisateur') final  String idUtilisateur;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCopyWith<_Notification> get copyWith => __$NotificationCopyWithImpl<_Notification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.date_envoi, date_envoi) || other.date_envoi == date_envoi)&&(identical(other.lu, lu) || other.lu == lu)&&(identical(other.idUtilisateur, idUtilisateur) || other.idUtilisateur == idUtilisateur)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,type,date_envoi,lu,idUtilisateur,createdAt);

@override
String toString() {
  return 'Notification(id: $id, message: $message, type: $type, date_envoi: $date_envoi, lu: $lu, idUtilisateur: $idUtilisateur, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_notification') String id,@JsonKey(name: 'message') String message,@JsonKey(name: 'type') String type,@JsonKey(name: 'date_envoi') DateTime? date_envoi,@JsonKey(name: 'lu') bool? lu,@JsonKey(name: 'id_utilisateur') String idUtilisateur,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(this._self, this._then);

  final _Notification _self;
  final $Res Function(_Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = null,Object? type = null,Object? date_envoi = freezed,Object? lu = freezed,Object? idUtilisateur = null,Object? createdAt = freezed,}) {
  return _then(_Notification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date_envoi: freezed == date_envoi ? _self.date_envoi : date_envoi // ignore: cast_nullable_to_non_nullable
as DateTime?,lu: freezed == lu ? _self.lu : lu // ignore: cast_nullable_to_non_nullable
as bool?,idUtilisateur: null == idUtilisateur ? _self.idUtilisateur : idUtilisateur // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
