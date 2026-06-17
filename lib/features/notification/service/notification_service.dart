import 'package:materelia/shared/services/supabase_service.dart';

class NotificationService {
  final _client = SupabaseService.client;

  /// Récupère les notifications non lues de l'utilisateur
  Future<List<Map<String, dynamic>>> fetchNotifications(String userId) async {
    try {
      final res = await _client
          .from('notifications')
          .select()
          .eq('id_utilisateur', userId)
          .order('date_envoi', ascending: false);

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Récupère les notifications non lues
  Future<List<Map<String, dynamic>>> fetchUnreadNotifications(String userId) async {
    try {
      final res = await _client
          .from('notifications')
          .select()
          .eq('id_utilisateur', userId)
          .eq('lu', false)
          .order('date_envoi', ascending: false);

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Marque une notification comme lue
  Future<void> markAsRead(String notificationId) async {
    try {
      await _client.from('notifications').update({'lu': true}).eq('id_notification', notificationId);
    } catch (e) {
      rethrow;
    }
  }

  /// Marque toutes les notifications comme lues
  Future<void> markAllAsRead(String userId) async {
    try {
      await _client.from('notifications').update({'lu': true}).eq('id_utilisateur', userId).eq('lu', false);
    } catch (e) {
      rethrow;
    }
  }

  /// Supprime une notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _client.from('notifications').delete().eq('id_notification', notificationId);
    } catch (e) {
      rethrow;
    }
  }
}
