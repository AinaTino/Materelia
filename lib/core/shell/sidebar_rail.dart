import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/router/app_router.dart';

NavigationRailDestination buildItem(String label, IconData icon) {
  return NavigationRailDestination(
    icon: Tooltip(
      message: label,
      child: Icon(icon),
    ),
    label: Text(label),
  );
}

class SidebarRail extends ConsumerStatefulWidget {
  final String role;
  const SidebarRail({super.key, required this.role});

  @override
  ConsumerState<SidebarRail> createState() => _SidebarRailState();
}

class _SidebarRailState extends ConsumerState<SidebarRail> {
  bool extended = false;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    int index = routeList.indexOf(location) ;
    index = index<0?0:index;
    String role = widget.role;
    
    return MouseRegion(
      onEnter: (_) => setState(() => extended = true),
      onExit: (_) => setState(() => extended = false),
      child: NavigationRail(
      selectedIndex: index,
      labelType: .none,
      extended: extended,
      onDestinationSelected: (i) {
        context.push(routeList[i]);
      },
      destinations: [
          // SIMPLE
          buildItem('Catalogue', Icons.inventory_2_outlined),
          buildItem('Mes Tickets', Icons.confirmation_number_outlined),
          buildItem('Mes Affectations', Icons.assignment_ind_outlined),

          if (role == AppConstants.roleTechnicien || role == AppConstants.roleAdmin)...{
          buildItem('Tickets Zone', Icons.support_agent_outlined),
          buildItem('Historique', Icons.history),
          },
          
          if (role == AppConstants.roleAdmin)...{
          buildItem('Dashboard', Icons.dashboard_outlined),
          buildItem('Affectations', Icons.assignment_outlined),
          buildItem('Matériels', Icons.devices_outlined),
          buildItem('Utilisateurs', Icons.group_outlined),
          buildItem('Zones', Icons.map_outlined),
          buildItem('Stocks', Icons.warehouse_outlined),
          },
          buildItem('Mon profil', Icons.person_outline),
        ]
    )
    );
  }
}