
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ligneticket.freezed.dart';
part 'ligneticket.g.dart';

@freezed
abstract class LigneTicket with _$LigneTicket {
  const factory LigneTicket({
    required String id_ligne_ticket,
    required String id_ticket,
    required String id_materiel,
    DateTime? created_at
  }) = _LigneTicket;
	
  factory LigneTicket.fromJson(Map<String, dynamic> json) =>
			_$LigneTicketFromJson(json);
}
