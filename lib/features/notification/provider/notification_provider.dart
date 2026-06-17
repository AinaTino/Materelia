import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/notification_service.dart';

final notificationServiceProvider = Provider((ref) => NotificationService());

/// Récupère toutes les notifications
final notificationsProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(notificationServiceProvider);
  return service.fetchNotifications(userId);
});

/// Récupère les notifications non lues
final unreadNotificationsProvider =
    FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(notificationServiceProvider);
  return service.fetchUnreadNotifications(userId);
});

/// Compte les notifications non lues
final unreadCountProvider = FutureProvider.autoDispose.family<int, String>((ref, userId) async {
  final unread = await ref.watch(unreadNotificationsProvider(userId).future);
  return unread.length;
});

// ── NOTIFIER ACTIONS ─────────────────────────────────────────────────────────

class NotificationActionNotifier extends AsyncNotifier<void> {
  NotificationService get _service => ref.read(notificationServiceProvider);

  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> markAsRead(String notificationId, String userId) async {
    state = const AsyncValue.loading();
    try {
      await _service.markAsRead(notificationId);
      ref.invalidate(notificationsProvider(userId));
      ref.invalidate(unreadNotificationsProvider(userId));
      ref.invalidate(unreadCountProvider(userId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> markAllAsRead(String userId) async {
    state = const AsyncValue.loading();
    try {
      await _service.markAllAsRead(userId);
      ref.invalidate(notificationsProvider(userId));
      ref.invalidate(unreadNotificationsProvider(userId));
      ref.invalidate(unreadCountProvider(userId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteNotification(String notificationId, String userId) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteNotification(notificationId);
      ref.invalidate(notificationsProvider(userId));
      ref.invalidate(unreadNotificationsProvider(userId));
      ref.invalidate(unreadCountProvider(userId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final notificationActionProvider =
    AsyncNotifierProvider<NotificationActionNotifier, void>(() => NotificationActionNotifier());
