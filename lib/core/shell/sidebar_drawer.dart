import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/router/app_router.dart';
import 'package:materelia/core/theme/app_colors.dart';

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
            height: 130,
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
          
          Container(
            padding: const EdgeInsets.only(left:15,top: 16,bottom:10),
            color: AppColors.secondaryContainer,
            child: Row(
              children: [
                Icon(Icons.dashboard,color: AppColors.onSecondaryContainer,),
                Text("   Mon espace", style: GoogleFonts.robotoFlex(
                  fontSize: 15,
                  color: AppColors.onSecondaryContainer
                ),)
              ],
            ),),
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
            Container(
              padding: const EdgeInsets.only(left:5,top: 16,bottom:10),
              color: AppColors.secondaryContainer,
              child: Row(
                children: [
                  Icon(Icons.build,color: AppColors.onSecondaryContainer,),
                  Text("  Technicien", style: GoogleFonts.robotoFlex(
                    fontSize: 15,
                    color: AppColors.onSecondaryContainer
                  ),)
                ],
              ),),
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
            Container(
              padding: const EdgeInsets.only(left:5,top: 16,bottom:10),
              color: AppColors.secondaryContainer,
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings,color: AppColors.onSecondaryContainer,),
                  Text("  Administration", style: GoogleFonts.robotoFlex(
                    fontSize: 15,
                    color: AppColors.onSecondaryContainer
                  ),)
                ],
              ),),
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
          Container(
  
            color: AppColors.secondaryContainer,
            child: 
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Mon profil", style: GoogleFonts.robotoFlex(
                    fontSize: 15,
                    color: AppColors.onSecondaryContainer
                  ),),
              onTap: () {
                context.go('/mon-profile');
                Navigator.pop(context);
                },
            )),
        ],
      ),
    );
  }
}