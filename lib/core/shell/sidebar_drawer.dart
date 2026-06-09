import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/router/app_router.dart';

class SidebarDrawer extends StatelessWidget {
  final String role;
  const SidebarDrawer({super.key,required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 140,
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('lib/assets/images/logo-withbg.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Materelia",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          Row(
            children: [
              Icon(Icons.person),
              Text("Mon profil")
            ],
          ),
          for (final s in routeSimple.entries) ...{
            ListTile(
              title: Text(s.value),
              onTap: () {
              context.go(s.key);
                Navigator.pop(context);
              },
            ),
          },

          if (role == AppConstants.roleTechnicien || role == AppConstants.roleAdmin)...{
            for (final s in routeTechnicien.entries) ...{
              ListTile(
                title: Text(s.value),
                onTap: () {
                context.go(s.key);
                  Navigator.pop(context);
                },
              ),
            },
          },

          if (role == AppConstants.roleAdmin)...{
            for (final s in routeAdmin.entries) ...{
              ListTile(
                title: Text(s.value),
                onTap: () {
                context.go(s.key);
                  Navigator.pop(context);
                },
              ),
            },
          },
        ],
      ),
    );
  }
}