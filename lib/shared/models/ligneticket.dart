
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ligneticket.freezed.dart';
part 'ligneticket.g.dart';

@freezed
abstract class LigneTicket with _$LigneTicket {
  const factory LigneTicket({
    @JsonKey(name: 'id_ligne_ticket') required String id,
    @JsonKey(name: 'id_ticket') required String idTicket,
    @JsonKey(name: 'id_materiel') required String idMateriel,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _LigneTicket;
	
  factory LigneTicket.fromJson(Map<String, dynamic> json) =>
			_$LigneTicketFromJson(json);
}
