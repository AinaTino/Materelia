import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              "Materelia",
              style: TextStyle(fontSize: 20),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              context.go('/dashboard');
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.confirmation_number),
            title: const Text("Tickets"),
            onTap: () {
              context.go('/tickets');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}