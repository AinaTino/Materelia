import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import '../provider/notification_provider.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  Color _getTypeColor(String type) {
    switch (type) {
      case 'NEW_TICKET':
        return AppColors.warning;
      case 'TICKET_VALIDATED':
        return AppColors.success;
      case 'TICKET_REFUSED':
      case 'TICKET_EXPIRED':
        return AppColors.error;
      case 'TICKET_IN_PROGRESS':
        return AppColors.info;
      case 'TICKET_RETURNED':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'NEW_TICKET':
        return 'Nouvelle demande';
      case 'TICKET_VALIDATED':
        return 'Demande validée';
      case 'TICKET_REFUSED':
        return 'Demande refusée';
      case 'TICKET_EXPIRED':
        return 'Demande expirée';
      case 'TICKET_IN_PROGRESS':
        return 'Retrait confirmé';
      case 'TICKET_RETURNED':
        return 'Retour confirmé';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: 'Marquer tout comme lu',
              onPressed: () async {
                final profile = await ref.read(profileControllerProvider.future);
                await ref.read(notificationActionProvider.notifier).markAllAsRead(profile.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Toutes les notifications marquées comme lues')),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (user) {
          final notificationsAsync = ref.watch(notificationsProvider(user.id));

          return notificationsAsync.when(
            data: (notifications) {
              if (notifications.isEmpty) {
                return const EmptyState(message: 'Aucune notification');
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  final id = notif['id_notification']?.toString() ?? '';
                  final message = notif['message']?.toString() ?? '';
                  final type = notif['type']?.toString() ?? '';
                  final isRead = notif['lu'] as bool? ?? false;
                  final dateRaw = notif['date_envoi']?.toString();
                  final date = dateRaw != null ? DateTime.parse(dateRaw) : null;

                  final dateStr = date != null
                      ? '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}'
                      : '';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: isRead ? 0 : 2,
                    color: isRead ? Colors.white : Colors.blue.shade50,
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getTypeColor(type).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconForType(type),
                          color: _getTypeColor(type),
                          size: 20,
                        ),
                      ),
                      title: Text(
                        _getTypeLabel(type),
                        style: TextStyle(
                          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            message,
                            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dateStr,
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('Marquer comme lu'),
                            onTap: () async {
                              await ref.read(notificationActionProvider.notifier).markAsRead(id, user.id);
                            },
                          ),
                          PopupMenuItem(
                            child: const Text('Supprimer'),
                            onTap: () async {
                              await ref.read(notificationActionProvider.notifier).deleteNotification(id, user.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erreur : $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur profile : $e')),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'NEW_TICKET':
        return Icons.assignment;
      case 'TICKET_VALIDATED':
        return Icons.check_circle;
      case 'TICKET_REFUSED':
        return Icons.cancel;
      case 'TICKET_EXPIRED':
        return Icons.schedule;
      case 'TICKET_IN_PROGRESS':
        return Icons.shopping_cart;
      case 'TICKET_RETURNED':
        return Icons.reply;
      default:
        return Icons.notifications;
    }
  }
}
