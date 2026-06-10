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

    if (role == AppConstants.roleTechnicien || role == AppConstants.roleAdmin) ...[
      null,
      '/tickets-zone',
      '/historique',
    ],

    if (role == AppConstants.roleAdmin) ...[
      null,
      '/dashboard',
      '/affectations',
      '/materiels',
      '/utilisateurs',
      '/zones',
      '/stocks',
    ],

    '/mon-profile',
  ];
}

NavigationRailDestination buildItem(String label, IconData icon,{Color color = const Color(0xFF000000)}) {
  return NavigationRailDestination(
    icon: Icon(icon),
    label: Text(label,style:TextStyle(color:color)),
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
            right: BorderSide(
              color: Color(0xFF8AB6ED),
              width: 1.5,
            ),
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
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
              if (route != null) {           // null = séparateur, on ignore
                context.go(route);
              }
            },
            leading: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                try { context.pop(); } catch (_) {}
              },
              child: const Icon(Icons.arrow_back),
            ),
            destinations:[
              // SIMPLE
              NavigationRailDestination(
                  icon: Icon(Icons.remove),
                  label: Text("Mon espace",style: TextStyle(color: AppColors.primary),),
                ),
              buildItem('Catalogue', Icons.inventory_2_outlined),
              buildItem('Mes Tickets', Icons.confirmation_number_outlined),
              buildItem('Mes Affectations', Icons.assignment_ind_outlined),

              if (role == AppConstants.roleTechnicien || role == AppConstants.roleAdmin)...{
                NavigationRailDestination(
                  icon: Icon(Icons.remove),
                  label: Text("Technicien",style: TextStyle(color: AppColors.primary)),
                ),
                buildItem('Tickets Zone', Icons.support_agent_outlined),
                buildItem('Historique', Icons.history),
              },

              if (role == AppConstants.roleAdmin)...{
                NavigationRailDestination(
                  icon: Icon(Icons.remove),
                  label: Text("Administration",style: TextStyle(color: AppColors.primary)),
                ),
                buildItem('Dashboard', Icons.dashboard_outlined),
                buildItem('Affectations', Icons.assignment_outlined),
                buildItem('Matériels', Icons.devices_outlined),
                buildItem('Utilisateurs', Icons.group_outlined),
                buildItem('Zones', Icons.map_outlined),
                buildItem('Stocks', Icons.warehouse_outlined),
              },
              buildItem('Mon profil', Icons.person_outline,color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}