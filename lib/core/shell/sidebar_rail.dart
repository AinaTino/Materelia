import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SidebarRail extends ConsumerWidget {
  const SidebarRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;

    int index = switch (location) {
      '/dashboard' => 0,
      '/tickets' => 1,
      _ => 0,
    };

    return NavigationRail(
      selectedIndex: index,
      onDestinationSelected: (i) {
        switch (i) {
          case 0:
            context.push('/dashboard');
            break;
          case 1:
            context.push('/tickets');
            break;
        }
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          label: Text("Dashboard"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.confirmation_number),
          label: Text("Tickets"),
        ),
      ],
    );
  }
}