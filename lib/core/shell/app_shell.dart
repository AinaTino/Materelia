import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/shell/sidebar_drawer.dart';
import 'package:materelia/core/shell/topbar.dart';
import 'package:materelia/core/shell/sidebar_rail.dart';
class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopBar(),
      ),

      drawer: isMobile ? const SidebarDrawer() : null,

      body: Row(
        children: [
          if (!isMobile) const SidebarRail(),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}