// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ticket {

 String get id_ticket; String get lieu_utilisation; DateTime get date_fin_prevue; DateTime? get date_creation; String get etat; int? get code_remise; DateTime? get date_expiration_code; DateTime? get date_validation; String? get motif_refus; String get id_demandeur; String? get id_valideur; String? get id_remetteur; String get id_zone; DateTime? get created_at;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id_ticket, id_ticket) || other.id_ticket == id_ticket)&&(identical(other.lieu_utilisation, lieu_utilisation) || other.lieu_utilisation == lieu_utilisation)&&(identical(other.date_fin_prevue, date_fin_prevue) || other.date_fin_prevue == date_fin_prevue)&&(identical(other.date_creation, date_creation) || other.date_creation == date_creation)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.code_remise, code_remise) || other.code_remise == code_remise)&&(identical(other.date_expiration_code, date_expiration_code) || other.date_expiration_code == date_expiration_code)&&(identical(other.date_validation, date_validation) || other.date_validation == date_validation)&&(identical(other.motif_refus, motif_refus) || other.motif_refus == motif_refus)&&(identical(other.id_demandeur, id_demandeur) || other.id_demandeur == id_demandeur)&&(identical(other.id_valideur, id_valideur) || other.id_valideur == id_valideur)&&(identical(other.id_remetteur, id_remetteur) || other.id_remetteur == id_remetteur)&&(identical(other.id_zone, id_zone) || other.id_zone == id_zone)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_ticket,lieu_utilisation,date_fin_prevue,date_creation,etat,code_remise,date_expiration_code,date_validation,motif_refus,id_demandeur,id_valideur,id_remetteur,id_zone,created_at);

@override
String toString() {
  return 'Ticket(id_ticket: $id_ticket, lieu_utilisation: $lieu_utilisation, date_fin_prevue: $date_fin_prevue, date_creation: $date_creation, etat: $etat, code_remise: $code_remise, date_expiration_code: $date_expiration_code, date_validation: $date_validation, motif_refus: $motif_refus, id_demandeur: $id_demandeur, id_valideur: $id_valideur, id_remetteur: $id_remetteur, id_zone: $id_zone, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 String id_ticket, String lieu_utilisation, DateTime date_fin_prevue, DateTime? date_creation, String etat, int? code_remise, DateTime? date_expiration_code, DateTime? date_validation, String? motif_refus, String id_demandeur, String? id_valideur, String? id_remetteur, String id_zone, DateTime? created_at
});




}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id_ticket = null,Object? lieu_utilisation = null,Object? date_fin_prevue = null,Object? date_creation = freezed,Object? etat = null,Object? code_remise = freezed,Object? date_expiration_code = freezed,Object? date_validation = freezed,Object? motif_refus = freezed,Object? id_demandeur = null,Object? id_valideur = freezed,Object? id_remetteur = freezed,Object? id_zone = null,Object? created_at = freezed,}) {
  return _then(_self.copyWith(
id_ticket: null == id_ticket ? _self.id_ticket : id_ticket // ignore: cast_nullable_to_non_nullable
as String,lieu_utilisation: null == lieu_utilisation ? _self.lieu_utilisation : lieu_utilisation // ignore: cast_nullable_to_non_nullable
as String,date_fin_prevue: null == date_fin_prevue ? _self.date_fin_prevue : date_fin_prevue // ignore: cast_nullable_to_non_nullable
as DateTime,date_creation: freezed == date_creation ? _self.date_creation : date_creation // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,code_remise: freezed == code_remise ? _self.code_remise : code_remise // ignore: cast_nullable_to_non_nullable
as int?,date_expiration_code: freezed == date_expiration_code ? _self.date_expiration_code : date_expiration_code // ignore: cast_nullable_to_non_nullable
as DateTime?,date_validation: freezed == date_validation ? _self.date_validation : date_validation // ignore: cast_nullable_to_non_nullable
as DateTime?,motif_refus: freezed == motif_refus ? _self.motif_refus : motif_refus // ignore: cast_nullable_to_non_nullable
as String?,id_demandeur: null == id_demandeur ? _self.id_demandeur : id_demandeur // ignore: cast_nullable_to_non_nullable
as String,id_valideur: freezed == id_valideur ? _self.id_valideur : id_valideur // ignore: cast_nullable_to_non_nullable
as String?,id_remetteur: freezed == id_remetteur ? _self.id_remetteur : id_remetteur // ignore: cast_nullable_to_non_nullable
as String?,id_zone: null == id_zone ? _self.id_zone : id_zone // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id_ticket,  String lieu_utilisation,  DateTime date_fin_prevue,  DateTime? date_creation,  String etat,  int? code_remise,  DateTime? date_expiration_code,  DateTime? date_validation,  String? motif_refus,  String id_demandeur,  String? id_valideur,  String? id_remetteur,  String id_zone,  DateTime? created_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id_ticket,_that.lieu_utilisation,_that.date_fin_prevue,_that.date_creation,_that.etat,_that.code_remise,_that.date_expiration_code,_that.date_validation,_that.motif_refus,_that.id_demandeur,_that.id_valideur,_that.id_remetteur,_that.id_zone,_that.created_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id_ticket,  String lieu_utilisation,  DateTime date_fin_prevue,  DateTime? date_creation,  String etat,  int? code_remise,  DateTime? date_expiration_code,  DateTime? date_validation,  String? motif_refus,  String id_demandeur,  String? id_valideur,  String? id_remetteur,  String id_zone,  DateTime? created_at)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id_ticket,_that.lieu_utilisation,_that.date_fin_prevue,_that.date_creation,_that.etat,_that.code_remise,_that.date_expiration_code,_that.date_validation,_that.motif_refus,_that.id_demandeur,_that.id_valideur,_that.id_remetteur,_that.id_zone,_that.created_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id_ticket,  String lieu_utilisation,  DateTime date_fin_prevue,  DateTime? date_creation,  String etat,  int? code_remise,  DateTime? date_expiration_code,  DateTime? date_validation,  String? motif_refus,  String id_demandeur,  String? id_valideur,  String? id_remetteur,  String id_zone,  DateTime? created_at)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id_ticket,_that.lieu_utilisation,_that.date_fin_prevue,_that.date_creation,_that.etat,_that.code_remise,_that.date_expiration_code,_that.date_validation,_that.motif_refus,_that.id_demandeur,_that.id_valideur,_that.id_remetteur,_that.id_zone,_that.created_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket implements Ticket {
  const _Ticket({required this.id_ticket, required this.lieu_utilisation, required this.date_fin_prevue, this.date_creation, required this.etat, this.code_remise, this.date_expiration_code, this.date_validation, this.motif_refus, required this.id_demandeur, this.id_valideur, this.id_remetteur, required this.id_zone, this.created_at});
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override final  String id_ticket;
@override final  String lieu_utilisation;
@override final  DateTime date_fin_prevue;
@override final  DateTime? date_creation;
@override final  String etat;
@override final  int? code_remise;
@override final  DateTime? date_expiration_code;
@override final  DateTime? date_validation;
@override final  String? motif_refus;
@override final  String id_demandeur;
@override final  String? id_valideur;
@override final  String? id_remetteur;
@override final  String id_zone;
@override final  DateTime? created_at;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id_ticket, id_ticket) || other.id_ticket == id_ticket)&&(identical(other.lieu_utilisation, lieu_utilisation) || other.lieu_utilisation == lieu_utilisation)&&(identical(other.date_fin_prevue, date_fin_prevue) || other.date_fin_prevue == date_fin_prevue)&&(identical(other.date_creation, date_creation) || other.date_creation == date_creation)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.code_remise, code_remise) || other.code_remise == code_remise)&&(identical(other.date_expiration_code, date_expiration_code) || other.date_expiration_code == date_expiration_code)&&(identical(other.date_validation, date_validation) || other.date_validation == date_validation)&&(identical(other.motif_refus, motif_refus) || other.motif_refus == motif_refus)&&(identical(other.id_demandeur, id_demandeur) || other.id_demandeur == id_demandeur)&&(identical(other.id_valideur, id_valideur) || other.id_valideur == id_valideur)&&(identical(other.id_remetteur, id_remetteur) || other.id_remetteur == id_remetteur)&&(identical(other.id_zone, id_zone) || other.id_zone == id_zone)&&(identical(other.created_at, created_at) || other.created_at == created_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id_ticket,lieu_utilisation,date_fin_prevue,date_creation,etat,code_remise,date_expiration_code,date_validation,motif_refus,id_demandeur,id_valideur,id_remetteur,id_zone,created_at);

@override
String toString() {
  return 'Ticket(id_ticket: $id_ticket, lieu_utilisation: $lieu_utilisation, date_fin_prevue: $date_fin_prevue, date_creation: $date_creation, etat: $etat, code_remise: $code_remise, date_expiration_code: $date_expiration_code, date_validation: $date_validation, motif_refus: $motif_refus, id_demandeur: $id_demandeur, id_valideur: $id_valideur, id_remetteur: $id_remetteur, id_zone: $id_zone, created_at: $created_at)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 String id_ticket, String lieu_utilisation, DateTime date_fin_prevue, DateTime? date_creation, String etat, int? code_remise, DateTime? date_expiration_code, DateTime? date_validation, String? motif_refus, String id_demandeur, String? id_valideur, String? id_remetteur, String id_zone, DateTime? created_at
});




}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id_ticket = null,Object? lieu_utilisation = null,Object? date_fin_prevue = null,Object? date_creation = freezed,Object? etat = null,Object? code_remise = freezed,Object? date_expiration_code = freezed,Object? date_validation = freezed,Object? motif_refus = freezed,Object? id_demandeur = null,Object? id_valideur = freezed,Object? id_remetteur = freezed,Object? id_zone = null,Object? created_at = freezed,}) {
  return _then(_Ticket(
id_ticket: null == id_ticket ? _self.id_ticket : id_ticket // ignore: cast_nullable_to_non_nullable
as String,lieu_utilisation: null == lieu_utilisation ? _self.lieu_utilisation : lieu_utilisation // ignore: cast_nullable_to_non_nullable
as String,date_fin_prevue: null == date_fin_prevue ? _self.date_fin_prevue : date_fin_prevue // ignore: cast_nullable_to_non_nullable
as DateTime,date_creation: freezed == date_creation ? _self.date_creation : date_creation // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,code_remise: freezed == code_remise ? _self.code_remise : code_remise // ignore: cast_nullable_to_non_nullable
as int?,date_expiration_code: freezed == date_expiration_code ? _self.date_expiration_code : date_expiration_code // ignore: cast_nullable_to_non_nullable
as DateTime?,date_validation: freezed == date_validation ? _self.date_validation : date_validation // ignore: cast_nullable_to_non_nullable
as DateTime?,motif_refus: freezed == motif_refus ? _self.motif_refus : motif_refus // ignore: cast_nullable_to_non_nullable
as String?,id_demandeur: null == id_demandeur ? _self.id_demandeur : id_demandeur // ignore: cast_nullable_to_non_nullable
as String,id_valideur: freezed == id_valideur ? _self.id_valideur : id_valideur // ignore: cast_nullable_to_non_nullable
as String?,id_remetteur: freezed == id_remetteur ? _self.id_remetteur : id_remetteur // ignore: cast_nullable_to_non_nullable
as String?,id_zone: null == id_zone ? _self.id_zone : id_zone // ignore: cast_nullable_to_non_nullable
as String,created_at: freezed == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
