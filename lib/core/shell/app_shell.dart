import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/shell/sidebar_drawer.dart';
import 'package:materelia/core/shell/topbar.dart';
import 'package:materelia/core/shell/sidebar_rail.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';

class AppShell extends ConsumerWidget {
  final Widget child;
  final String title;

  const AppShell({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final profile = ref.watch(profileControllerProvider);
    String role ="Chargement";
    
    profile.when(
      data: (user)=> role=user.role,
      error: (error, stackTrace) => role="Erreur",
      loading: () => role="Chargement",
      );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopBar(title: title),
      ),

      drawer: isMobile ? SidebarDrawer(role: role) : null,

      body: Row(
        children: [
          if (!isMobile) SidebarRail(role: role),
          const VerticalDivider(width: 1),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}