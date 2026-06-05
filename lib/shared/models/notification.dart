
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    @JsonKey(name: 'id_notification') required String id,
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'date_envoi') DateTime? date_envoi,
    @JsonKey(name: 'lu') bool? lu,
    @JsonKey(name: 'id_utilisateur') required String idUtilisateur,
    @JsonKey(name: 'created_at') DateTime? createdAt
  }) = _Notification;
	
  factory Notification.fromJson(Map<String, dynamic> json) =>
			_$NotificationFromJson(json);
}
