import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';

List<String?> _buildRouteMap(String role) {
  return [
    null,
    '/catalogue',
    '/mes-tickets',
    '/mes-affectations',
    '/mes-demandes',

    if (role == AppConstants.roleTechnicien ||
        role == AppConstants.roleAdmin) ...[
      null,
      '/tickets-zone',
      '/historique',
    ],

    if (role == AppConstants.roleAdmin) ...[
      null,
      '/dashboard',
      '/affectations',
      '/demandes-affectations',
      '/materiels',
      '/utilisateurs',
      '/zones',
      '/stocks',
    ],

    '/mon-profil',
  ];
}

NavigationRailDestination buildItem(
  String label,
  IconData icon,
  IconData selectedIcon, {
  Color color = const Color(0xFF000000),
}) {
  return NavigationRailDestination(
    icon: Icon(icon),
    selectedIcon: Icon(selectedIcon),
    label: Text(label, style: TextStyle(color: color)),
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
    final String role = widget.role;
    final routeMap = _buildRouteMap(role);
    final index = routeMap.indexOf(location);
    final selectedIndex = index < 0 ? 1 : index;

    return MouseRegion(
      onEnter: (_) => setState(() => extended = true),
      onExit: (_) => setState(() => extended = false),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF7FF),
          border: const Border(
            right: BorderSide(color: Color(0xFF8AB6ED), width: 1.5),
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: NavigationRail(
            scrollable: true,
            backgroundColor: Colors.transparent,
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.none,
            extended: extended,
            onDestinationSelected: (i) {
              final route = routeMap[i];
              if (route != null) {
                // null = séparateur, on ignore
                context.go(route);
              }
            },
            leading: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                try {
                  context.pop();
                } catch (_) {}
              },
              child: const Icon(Icons.arrow_back),
            ),
            destinations: [
              // SIMPLE
              NavigationRailDestination(
                icon: Icon(Icons.remove),
                label: Text(
                  "Mon espace",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              buildItem(
                'Catalogue',
                Icons.inventory_2_outlined,
                Icons.inventory_2,
              ),
              buildItem(
                'Mes Tickets',
                Icons.confirmation_number_outlined,
                Icons.confirmation_number,
              ),
              buildItem(
                'Mes Affectations',
                Icons.assignment_ind_outlined,
                Icons.assignment_ind,
              ),
              buildItem(
                "Mes demandes d'affectations",
                Icons.badge_outlined,
                Icons.badge,
              ),

              if (role == AppConstants.roleTechnicien ||
                  role == AppConstants.roleAdmin) ...{
                NavigationRailDestination(
                  icon: Icon(Icons.remove),
                  label: Text(
                    "Technicien",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                buildItem(
                  'Tickets Zone',
                  Icons.support_agent_outlined,
                  Icons.support_agent,
                ),
                buildItem('Historique', Icons.history_outlined, Icons.history),
              },

              if (role == AppConstants.roleAdmin) ...{
                NavigationRailDestination(
                  icon: Icon(Icons.remove),
                  label: Text(
                    "Administration",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                buildItem(
                  'Dashboard',
                  Icons.dashboard_outlined,
                  Icons.dashboard,
                ),
                buildItem(
                  'Affectations',
                  Icons.assignment_outlined,
                  Icons.assignment,
                ),
                buildItem(
                  "Demandes d'affectation",
                  Icons.work_outlined,
                  Icons.work,
                ),
                buildItem('Matériels', Icons.devices_outlined, Icons.devices),
                buildItem('Utilisateurs', Icons.group_outlined, Icons.group),
                buildItem('Zones', Icons.map_outlined, Icons.map),
                buildItem('Stocks', Icons.warehouse_outlined, Icons.warehouse),
              },
              buildItem(
                'Mon profil',
                Icons.person_outlined,
                Icons.person,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
