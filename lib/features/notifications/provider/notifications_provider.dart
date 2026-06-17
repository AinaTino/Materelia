// lib/features/notifications/provider/notifications_provider.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/notifications/service/notifications_service.dart';
import 'package:materelia/shared/models/notification.dart';
import 'package:materelia/shared/services/supabase_service.dart';

final notificationsServiceProvider = Provider((_) => NotificationsService());

// Provider principal — liste complète
class NotificationsController extends AsyncNotifier<List<Notification>> {
  StreamSubscription? _sub;

  @override
  Future<List<Notification>> build() async {
    final userId = SupabaseService.currentSession?.user.id;
    if (userId == null) return [];

    final service = ref.read(notificationsServiceProvider);
    final initial = await service.fetchAll(userId);

    // Realtime : INSERT ou UPDATE → refresh
    _sub?.cancel();
    _sub = SupabaseService.client
        .from('notifications')
        .stream(primaryKey: ['id_notification'])
        .eq('id_utilisateur', userId)
        .order('date_envoi', ascending: false)
        .listen((rows) {
          state = AsyncData(rows.map((e) => Notification.fromJson(e)).toList());
        });

    ref.onDispose(() => _sub?.cancel());
    return initial;
  }

  Future<void> marquerLu(String id) async {
    await ref.read(notificationsServiceProvider).marquerLu(id);
  }

  Future<void> marquerToutLu() async {
    final userId = SupabaseService.currentSession?.user.id;
    if (userId == null) return;
    await ref.read(notificationsServiceProvider).marquerToutLu(userId);
  }

  Future<void> supprimer(String id) async {
    await ref.read(notificationsServiceProvider).supprimer(id);
  }
}

final notificationsControllerProvider =
    AsyncNotifierProvider<NotificationsController, List<Notification>>(
      NotificationsController.new,
    );

// Badge : nombre de non lus
final notifNonLuCountProvider = Provider<int>((ref) {
  final async = ref.watch(notificationsControllerProvider);
  return async.maybeWhen(
    data: (list) => list.where((n) => !(n.lu ?? false)).length,
    orElse: () => 0,
  );
});
