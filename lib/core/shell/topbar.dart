import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/features/notifications/provider/notifications_provider.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class TopBar extends ConsumerWidget {
  final String title;
  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(notifNonLuCountProvider);
    return AppBar(
      centerTitle: true,
      title: Text(
        '${MediaQuery.of(context).size.width < 800 ? '' : 'Materelia -'} $title',
      ),

      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notifications',
              onPressed: () => context.push('/notifications'),
            ),
            if (count > 0)
              Positioned(
                top: 4,
                right: 4,
                child: IgnorePointer(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      count > 99 ? '99+' : '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: 'Mon profil',
          onPressed: () => context.push('/mon-profil'),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Se déconnecter',
          onPressed: () async {
            await SupabaseService.client.auth.signOut();
          },
        ),
      ],
    );
  }
}
