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

 String get id_notification; String get message; String get type; DateTime? get date_envoi; bool? get lu; String get id_utilisateur; DateTime? get created_at;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id_notification, id_notification) || other.id_notification == id_notification)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.date_envoi, date_envoi) || other.date_envoi == date_envoi)&&(identical(other.lu, lu) || other.lu == lu)&&(identical(other.id_utilisateur, id_utilisateur) || other.id_utilisateur == id_utilisateur)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_notification,message,type,date_envoi,lu,id_utilisateur,created_at);

@override
String toString() {
  return 'Notification(id_notification: $id_notification, message: $message, type: $type, date_envoi: $date_envoi, lu: $lu, id_utilisateur: $id_utilisateur, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
 String id_notification, String message, String type, DateTime? date_envoi, bool? lu, String id_utilisateur, DateTime? created_at
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
@pragma('vm:prefer-inline') @override $Res call({Object? id_notification = null,Object? message = null,Object? type = null,Object? date_envoi = freezed,Object? lu = freezed,Object? id_utilisateur = null,Object? created_at = freezed,}) {
  return _then(_self.copyWith(
id_notification: null == id_notification ? _self.id_notification : id_notification // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date_envoi: freezed == date_envoi ? _self.date_envoi : date_envoi // ignore: cast_nullable_to_non_nullable
as DateTime?,lu: freezed == lu ? _self.lu : lu // ignore: cast_nullable_to_non_nullable
as bool?,id_utilisateur: null == id_utilisateur ? _self.id_utilisateur : id_utilisateur // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id_notification,  String message,  String type,  DateTime? date_envoi,  bool? lu,  String id_utilisateur,  DateTime? created_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id_notification,_that.message,_that.type,_that.date_envoi,_that.lu,_that.id_utilisateur,_that.created_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id_notification,  String message,  String type,  DateTime? date_envoi,  bool? lu,  String id_utilisateur,  DateTime? created_at)  $default,) {final _that = this;
switch (_that) {
case _Notification():
return $default(_that.id_notification,_that.message,_that.type,_that.date_envoi,_that.lu,_that.id_utilisateur,_that.created_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id_notification,  String message,  String type,  DateTime? date_envoi,  bool? lu,  String id_utilisateur,  DateTime? created_at)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id_notification,_that.message,_that.type,_that.date_envoi,_that.lu,_that.id_utilisateur,_that.created_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Notification implements Notification {
  const _Notification({required this.id_notification, required this.message, required this.type, this.date_envoi, this.lu, required this.id_utilisateur, this.created_at});
  factory _Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

@override final  String id_notification;
@override final  String message;
@override final  String type;
@override final  DateTime? date_envoi;
@override final  bool? lu;
@override final  String id_utilisateur;
@override final  DateTime? created_at;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.id_notification, id_notification) || other.id_notification == id_notification)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.date_envoi, date_envoi) || other.date_envoi == date_envoi)&&(identical(other.lu, lu) || other.lu == lu)&&(identical(other.id_utilisateur, id_utilisateur) || other.id_utilisateur == id_utilisateur)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_notification,message,type,date_envoi,lu,id_utilisateur,created_at);

@override
String toString() {
  return 'Notification(id_notification: $id_notification, message: $message, type: $type, date_envoi: $date_envoi, lu: $lu, id_utilisateur: $id_utilisateur, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
 String id_notification, String message, String type, DateTime? date_envoi, bool? lu, String id_utilisateur, DateTime? created_at
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
@override @pragma('vm:prefer-inline') $Res call({Object? id_notification = null,Object? message = null,Object? type = null,Object? date_envoi = freezed,Object? lu = freezed,Object? id_utilisateur = null,Object? created_at = freezed,}) {
  return _then(_Notification(
id_notification: null == id_notification ? _self.id_notification : id_notification // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date_envoi: freezed == date_envoi ? _self.date_envoi : date_envoi // ignore: cast_nullable_to_non_nullable
as DateTime?,lu: freezed == lu ? _self.lu : lu // ignore: cast_nullable_to_non_nullable
as bool?,id_utilisateur: null == id_utilisateur ? _self.id_utilisateur : id_utilisateur // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
