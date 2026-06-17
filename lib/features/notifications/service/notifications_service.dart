// lib/features/notifications/service/notifications_service.dart
import 'package:materelia/shared/models/notification.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class NotificationsService {
  final _client = SupabaseService.client;

  Future<List<Notification>> fetchAll(String idUtilisateur) async {
    final data = await _client
        .from('notifications')
        .select()
        .eq('id_utilisateur', idUtilisateur)
        .order('date_envoi', ascending: false);
    return (data as List).map((e) => Notification.fromJson(e)).toList();
  }

  Future<void> marquerLu(String idNotification) async {
    await _client
        .from('notifications')
        .update({'lu': true})
        .eq('id_notification', idNotification);
  }

  Future<void> marquerToutLu(String idUtilisateur) async {
    await _client
        .from('notifications')
        .update({'lu': true})
        .eq('id_utilisateur', idUtilisateur)
        .eq('lu', false);
  }

  Future<void> supprimer(String idNotification) async {
    await _client
        .from('notifications')
        .delete()
        .eq('id_notification', idNotification);
  }

  Future<void> envoyerNotif({
    required String idUtilisateur,
    required String message,
    required String type,
    String? route,
  }) async {
    await _client.from('notifications').insert({
      'id_utilisateur': idUtilisateur,
      'message': message,
      'type': type,
      'route': route,
      'lu': false,
    });
  }

  Future<List<String>> getAdminIds() async {
    final data = await _client
        .from('utilisateurs')
        .select('id_utilisateur')
        .eq('role', 'ADMIN');
    return (data as List).map((e) => e['id_utilisateur'] as String).toList();
  }
}
