// lib/features/notifications/UI/notifications_page.dart
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/features/notifications/provider/notifications_provider.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/models/notification.dart';
import 'package:materelia/shared/widgets/loading.dart';

// Icône selon type
IconData _iconFromType(String type) => switch (type) {
  'AFFECTATION' => Icons.assignment_outlined,
  'DEMANDE' => Icons.inbox_outlined,
  'TICKET' => Icons.confirmation_number_outlined,
  'ALERTE' => Icons.warning_amber_outlined,
  _ => Icons.notifications_outlined,
};

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(notificationsControllerProvider);
    final controller = ref.read(notificationsControllerProvider.notifier);
    final nonLuCount = ref.watch(notifNonLuCountProvider);

    return Column(
      children: [
        // Header actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Text(
                nonLuCount > 0 ? '$nonLuCount non lue(s)' : 'Tout lu',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (nonLuCount > 0)
                TextButton.icon(
                  onPressed: controller.marquerToutLu,
                  icon: const Icon(Icons.done_all, size: 16),
                  label: const Text('Tout marquer lu'),
                ),
            ],
          ),
        ),
        const Divider(height: 1),

        Expanded(
          child: async.when(
            loading: () => const AppLoading(),
            error: (e, _) => ErrorView(
              message: e.toString(),
              onRetry: () => ref.invalidate(notificationsControllerProvider),
            ),
            data: (liste) {
              if (liste.isEmpty) {
                return const Center(
                  child: FeedbackCard(
                    icon: Icons.notifications_none,
                    type: FeedbackType.info,
                    title: 'Aucune notification',
                    message: 'Vous êtes à jour.',
                  ),
                );
              }

              return ListView.separated(
                itemCount: liste.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final n = liste[i];
                  return _NotifTile(
                    notif: n,
                    onTap: () async {
                      if (!(n.lu ?? false)) await controller.marquerLu(n.id);
                      if (n.route != null && context.mounted) {
                        context.push(n.route!);
                      }
                    },
                    onDismiss: () => controller.supprimer(n.id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NotifTile extends StatelessWidget {
  final Notification notif; // Dans _NotifTile, change le type
  final Future<void> Function() onTap; // au lieu de VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotifTile({
    required this.notif,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(notif.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: colorScheme.errorContainer,
        child: Icon(Icons.delete_outline, color: colorScheme.onErrorContainer),
      ),
      onDismissed: (_) => onDismiss(),
      child: ListTile(
        onTap: onTap,
        tileColor: (notif.lu ?? false)
            ? null
            : colorScheme.primaryContainer.withValues(alpha: 0.15),
        leading: CircleAvatar(
          backgroundColor: (notif.lu ?? false)
              ? colorScheme.surfaceContainerHighest
              : colorScheme.primaryContainer,
          child: Icon(
            _iconFromType(notif.type),
            size: 18,
            color: (notif.lu ?? false)
                ? colorScheme.onSurfaceVariant
                : colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          notif.message,
          style: TextStyle(
            fontWeight: (notif.lu ?? false)
                ? FontWeight.normal
                : FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: notif.dateEnvoi != null
            ? Text(
                dateConvert(notif.dateEnvoi!),
                style: Theme.of(context).textTheme.bodySmall,
              )
            : null,
        trailing: (notif.lu ?? false)
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
      ),
    );
  }
}
