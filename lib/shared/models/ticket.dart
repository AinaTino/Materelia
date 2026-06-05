
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    @JsonKey(name: 'id_ticket') required String id,
    @JsonKey(name: 'lieu_utilisation') required String lieuUtilisation,
    @JsonKey(name: 'date_fin_prevue') required DateTime dateFinPrevue,
    @JsonKey(name: 'date_creation') DateTime? dateCreation,
    @JsonKey(name: 'etat') required String etat,
    @JsonKey(name: 'code_remise') int? codeRemise,
    @JsonKey(name: 'date_expiration_code') DateTime? dateExpirationCode,
    @JsonKey(name: 'date_validation') DateTime? dateValidation,
    @JsonKey(name: 'motif_refus') String? motifRefus,
    @JsonKey(name: 'id_demandeur') required String idDemandeur,
    @JsonKey(name: 'id_valideur') String? idValideur,
    @JsonKey(name: 'id_remetteur') String? idRemetteur,
    @JsonKey(name: 'id_zone') required String idZone,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Ticket;
	
  factory Ticket.fromJson(Map<String, dynamic> json) =>
			_$TicketFromJson(json);
}
