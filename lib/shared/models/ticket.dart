
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    required String id_ticket,
    required String lieu_utilisation,
    required DateTime date_fin_prevue,
    DateTime? date_creation,
    required String etat,
    int? code_remise,
    DateTime? date_expiration_code,
    DateTime? date_validation,
    String? motif_refus,
    required String id_demandeur,
    String? id_valideur,
    String? id_remetteur,
    required String id_zone,
    DateTime? created_at
  }) = _Ticket;
	
  factory Ticket.fromJson(Map<String, dynamic> json) =>
			_$TicketFromJson(json);
}
