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

@JsonKey(name: 'id_ticket') String get id;@JsonKey(name: 'lieu_utilisation') String get lieuUtilisation;@JsonKey(name: 'date_fin_prevue') DateTime get dateFinPrevue;@JsonKey(name: 'date_creation') DateTime? get dateCreation;@JsonKey(name: 'etat') String get etat;@JsonKey(name: 'code_remise') int? get codeRemise;@JsonKey(name: 'date_expiration_code') DateTime? get dateExpirationCode;@JsonKey(name: 'date_validation') DateTime? get dateValidation;@JsonKey(name: 'motif_refus') String? get motifRefus;@JsonKey(name: 'id_demandeur') String get idDemandeur;@JsonKey(name: 'id_valideur') String? get idValideur;@JsonKey(name: 'id_remetteur') String? get idRemetteur;@JsonKey(name: 'id_zone') String get idZone;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.lieuUtilisation, lieuUtilisation) || other.lieuUtilisation == lieuUtilisation)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.dateCreation, dateCreation) || other.dateCreation == dateCreation)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.codeRemise, codeRemise) || other.codeRemise == codeRemise)&&(identical(other.dateExpirationCode, dateExpirationCode) || other.dateExpirationCode == dateExpirationCode)&&(identical(other.dateValidation, dateValidation) || other.dateValidation == dateValidation)&&(identical(other.motifRefus, motifRefus) || other.motifRefus == motifRefus)&&(identical(other.idDemandeur, idDemandeur) || other.idDemandeur == idDemandeur)&&(identical(other.idValideur, idValideur) || other.idValideur == idValideur)&&(identical(other.idRemetteur, idRemetteur) || other.idRemetteur == idRemetteur)&&(identical(other.idZone, idZone) || other.idZone == idZone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lieuUtilisation,dateFinPrevue,dateCreation,etat,codeRemise,dateExpirationCode,dateValidation,motifRefus,idDemandeur,idValideur,idRemetteur,idZone,createdAt);

@override
String toString() {
  return 'Ticket(id: $id, lieuUtilisation: $lieuUtilisation, dateFinPrevue: $dateFinPrevue, dateCreation: $dateCreation, etat: $etat, codeRemise: $codeRemise, dateExpirationCode: $dateExpirationCode, dateValidation: $dateValidation, motifRefus: $motifRefus, idDemandeur: $idDemandeur, idValideur: $idValideur, idRemetteur: $idRemetteur, idZone: $idZone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_ticket') String id,@JsonKey(name: 'lieu_utilisation') String lieuUtilisation,@JsonKey(name: 'date_fin_prevue') DateTime dateFinPrevue,@JsonKey(name: 'date_creation') DateTime? dateCreation,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'code_remise') int? codeRemise,@JsonKey(name: 'date_expiration_code') DateTime? dateExpirationCode,@JsonKey(name: 'date_validation') DateTime? dateValidation,@JsonKey(name: 'motif_refus') String? motifRefus,@JsonKey(name: 'id_demandeur') String idDemandeur,@JsonKey(name: 'id_valideur') String? idValideur,@JsonKey(name: 'id_remetteur') String? idRemetteur,@JsonKey(name: 'id_zone') String idZone,@JsonKey(name: 'created_at') DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lieuUtilisation = null,Object? dateFinPrevue = null,Object? dateCreation = freezed,Object? etat = null,Object? codeRemise = freezed,Object? dateExpirationCode = freezed,Object? dateValidation = freezed,Object? motifRefus = freezed,Object? idDemandeur = null,Object? idValideur = freezed,Object? idRemetteur = freezed,Object? idZone = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lieuUtilisation: null == lieuUtilisation ? _self.lieuUtilisation : lieuUtilisation // ignore: cast_nullable_to_non_nullable
as String,dateFinPrevue: null == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime,dateCreation: freezed == dateCreation ? _self.dateCreation : dateCreation // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,codeRemise: freezed == codeRemise ? _self.codeRemise : codeRemise // ignore: cast_nullable_to_non_nullable
as int?,dateExpirationCode: freezed == dateExpirationCode ? _self.dateExpirationCode : dateExpirationCode // ignore: cast_nullable_to_non_nullable
as DateTime?,dateValidation: freezed == dateValidation ? _self.dateValidation : dateValidation // ignore: cast_nullable_to_non_nullable
as DateTime?,motifRefus: freezed == motifRefus ? _self.motifRefus : motifRefus // ignore: cast_nullable_to_non_nullable
as String?,idDemandeur: null == idDemandeur ? _self.idDemandeur : idDemandeur // ignore: cast_nullable_to_non_nullable
as String,idValideur: freezed == idValideur ? _self.idValideur : idValideur // ignore: cast_nullable_to_non_nullable
as String?,idRemetteur: freezed == idRemetteur ? _self.idRemetteur : idRemetteur // ignore: cast_nullable_to_non_nullable
as String?,idZone: null == idZone ? _self.idZone : idZone // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_ticket')  String id, @JsonKey(name: 'lieu_utilisation')  String lieuUtilisation, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_creation')  DateTime? dateCreation, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'code_remise')  int? codeRemise, @JsonKey(name: 'date_expiration_code')  DateTime? dateExpirationCode, @JsonKey(name: 'date_validation')  DateTime? dateValidation, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_remetteur')  String? idRemetteur, @JsonKey(name: 'id_zone')  String idZone, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.lieuUtilisation,_that.dateFinPrevue,_that.dateCreation,_that.etat,_that.codeRemise,_that.dateExpirationCode,_that.dateValidation,_that.motifRefus,_that.idDemandeur,_that.idValideur,_that.idRemetteur,_that.idZone,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_ticket')  String id, @JsonKey(name: 'lieu_utilisation')  String lieuUtilisation, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_creation')  DateTime? dateCreation, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'code_remise')  int? codeRemise, @JsonKey(name: 'date_expiration_code')  DateTime? dateExpirationCode, @JsonKey(name: 'date_validation')  DateTime? dateValidation, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_remetteur')  String? idRemetteur, @JsonKey(name: 'id_zone')  String idZone, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.lieuUtilisation,_that.dateFinPrevue,_that.dateCreation,_that.etat,_that.codeRemise,_that.dateExpirationCode,_that.dateValidation,_that.motifRefus,_that.idDemandeur,_that.idValideur,_that.idRemetteur,_that.idZone,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_ticket')  String id, @JsonKey(name: 'lieu_utilisation')  String lieuUtilisation, @JsonKey(name: 'date_fin_prevue')  DateTime dateFinPrevue, @JsonKey(name: 'date_creation')  DateTime? dateCreation, @JsonKey(name: 'etat')  String etat, @JsonKey(name: 'code_remise')  int? codeRemise, @JsonKey(name: 'date_expiration_code')  DateTime? dateExpirationCode, @JsonKey(name: 'date_validation')  DateTime? dateValidation, @JsonKey(name: 'motif_refus')  String? motifRefus, @JsonKey(name: 'id_demandeur')  String idDemandeur, @JsonKey(name: 'id_valideur')  String? idValideur, @JsonKey(name: 'id_remetteur')  String? idRemetteur, @JsonKey(name: 'id_zone')  String idZone, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.lieuUtilisation,_that.dateFinPrevue,_that.dateCreation,_that.etat,_that.codeRemise,_that.dateExpirationCode,_that.dateValidation,_that.motifRefus,_that.idDemandeur,_that.idValideur,_that.idRemetteur,_that.idZone,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket implements Ticket {
  const _Ticket({@JsonKey(name: 'id_ticket') required this.id, @JsonKey(name: 'lieu_utilisation') required this.lieuUtilisation, @JsonKey(name: 'date_fin_prevue') required this.dateFinPrevue, @JsonKey(name: 'date_creation') this.dateCreation, @JsonKey(name: 'etat') required this.etat, @JsonKey(name: 'code_remise') this.codeRemise, @JsonKey(name: 'date_expiration_code') this.dateExpirationCode, @JsonKey(name: 'date_validation') this.dateValidation, @JsonKey(name: 'motif_refus') this.motifRefus, @JsonKey(name: 'id_demandeur') required this.idDemandeur, @JsonKey(name: 'id_valideur') this.idValideur, @JsonKey(name: 'id_remetteur') this.idRemetteur, @JsonKey(name: 'id_zone') required this.idZone, @JsonKey(name: 'created_at') this.createdAt});
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override@JsonKey(name: 'id_ticket') final  String id;
@override@JsonKey(name: 'lieu_utilisation') final  String lieuUtilisation;
@override@JsonKey(name: 'date_fin_prevue') final  DateTime dateFinPrevue;
@override@JsonKey(name: 'date_creation') final  DateTime? dateCreation;
@override@JsonKey(name: 'etat') final  String etat;
@override@JsonKey(name: 'code_remise') final  int? codeRemise;
@override@JsonKey(name: 'date_expiration_code') final  DateTime? dateExpirationCode;
@override@JsonKey(name: 'date_validation') final  DateTime? dateValidation;
@override@JsonKey(name: 'motif_refus') final  String? motifRefus;
@override@JsonKey(name: 'id_demandeur') final  String idDemandeur;
@override@JsonKey(name: 'id_valideur') final  String? idValideur;
@override@JsonKey(name: 'id_remetteur') final  String? idRemetteur;
@override@JsonKey(name: 'id_zone') final  String idZone;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.lieuUtilisation, lieuUtilisation) || other.lieuUtilisation == lieuUtilisation)&&(identical(other.dateFinPrevue, dateFinPrevue) || other.dateFinPrevue == dateFinPrevue)&&(identical(other.dateCreation, dateCreation) || other.dateCreation == dateCreation)&&(identical(other.etat, etat) || other.etat == etat)&&(identical(other.codeRemise, codeRemise) || other.codeRemise == codeRemise)&&(identical(other.dateExpirationCode, dateExpirationCode) || other.dateExpirationCode == dateExpirationCode)&&(identical(other.dateValidation, dateValidation) || other.dateValidation == dateValidation)&&(identical(other.motifRefus, motifRefus) || other.motifRefus == motifRefus)&&(identical(other.idDemandeur, idDemandeur) || other.idDemandeur == idDemandeur)&&(identical(other.idValideur, idValideur) || other.idValideur == idValideur)&&(identical(other.idRemetteur, idRemetteur) || other.idRemetteur == idRemetteur)&&(identical(other.idZone, idZone) || other.idZone == idZone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lieuUtilisation,dateFinPrevue,dateCreation,etat,codeRemise,dateExpirationCode,dateValidation,motifRefus,idDemandeur,idValideur,idRemetteur,idZone,createdAt);

@override
String toString() {
  return 'Ticket(id: $id, lieuUtilisation: $lieuUtilisation, dateFinPrevue: $dateFinPrevue, dateCreation: $dateCreation, etat: $etat, codeRemise: $codeRemise, dateExpirationCode: $dateExpirationCode, dateValidation: $dateValidation, motifRefus: $motifRefus, idDemandeur: $idDemandeur, idValideur: $idValideur, idRemetteur: $idRemetteur, idZone: $idZone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_ticket') String id,@JsonKey(name: 'lieu_utilisation') String lieuUtilisation,@JsonKey(name: 'date_fin_prevue') DateTime dateFinPrevue,@JsonKey(name: 'date_creation') DateTime? dateCreation,@JsonKey(name: 'etat') String etat,@JsonKey(name: 'code_remise') int? codeRemise,@JsonKey(name: 'date_expiration_code') DateTime? dateExpirationCode,@JsonKey(name: 'date_validation') DateTime? dateValidation,@JsonKey(name: 'motif_refus') String? motifRefus,@JsonKey(name: 'id_demandeur') String idDemandeur,@JsonKey(name: 'id_valideur') String? idValideur,@JsonKey(name: 'id_remetteur') String? idRemetteur,@JsonKey(name: 'id_zone') String idZone,@JsonKey(name: 'created_at') DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lieuUtilisation = null,Object? dateFinPrevue = null,Object? dateCreation = freezed,Object? etat = null,Object? codeRemise = freezed,Object? dateExpirationCode = freezed,Object? dateValidation = freezed,Object? motifRefus = freezed,Object? idDemandeur = null,Object? idValideur = freezed,Object? idRemetteur = freezed,Object? idZone = null,Object? createdAt = freezed,}) {
  return _then(_Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lieuUtilisation: null == lieuUtilisation ? _self.lieuUtilisation : lieuUtilisation // ignore: cast_nullable_to_non_nullable
as String,dateFinPrevue: null == dateFinPrevue ? _self.dateFinPrevue : dateFinPrevue // ignore: cast_nullable_to_non_nullable
as DateTime,dateCreation: freezed == dateCreation ? _self.dateCreation : dateCreation // ignore: cast_nullable_to_non_nullable
as DateTime?,etat: null == etat ? _self.etat : etat // ignore: cast_nullable_to_non_nullable
as String,codeRemise: freezed == codeRemise ? _self.codeRemise : codeRemise // ignore: cast_nullable_to_non_nullable
as int?,dateExpirationCode: freezed == dateExpirationCode ? _self.dateExpirationCode : dateExpirationCode // ignore: cast_nullable_to_non_nullable
as DateTime?,dateValidation: freezed == dateValidation ? _self.dateValidation : dateValidation // ignore: cast_nullable_to_non_nullable
as DateTime?,motifRefus: freezed == motifRefus ? _self.motifRefus : motifRefus // ignore: cast_nullable_to_non_nullable
as String?,idDemandeur: null == idDemandeur ? _self.idDemandeur : idDemandeur // ignore: cast_nullable_to_non_nullable
as String,idValideur: freezed == idValideur ? _self.idValideur : idValideur // ignore: cast_nullable_to_non_nullable
as String?,idRemetteur: freezed == idRemetteur ? _self.idRemetteur : idRemetteur // ignore: cast_nullable_to_non_nullable
as String?,idZone: null == idZone ? _self.idZone : idZone // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
