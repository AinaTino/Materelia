
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String id_notification,
    required String message,
    required String type,
    DateTime? date_envoi,
    bool? lu,
    required String id_utilisateur,
    DateTime? created_at
  }) = _Notification;
	
  factory Notification.fromJson(Map<String, dynamic> json) =>
			_$NotificationFromJson(json);
}
