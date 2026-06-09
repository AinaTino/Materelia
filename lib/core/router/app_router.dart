import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:materelia/core/shell/app_shell.dart";
import "package:materelia/features/auth/UI/auth_page.dart";
import "package:materelia/features/auth/UI/signin_page.dart";
import "package:materelia/features/auth/UI/signup_page.dart";
import "package:materelia/shared/services/auth_notifier.dart";
import "package:materelia/shared/services/supabase_service.dart";
import "package:materelia/shared/widgets/loading.dart";

final authNotifier = AuthNotifier();

final rootRouter = GoRouter(
  refreshListenable: authNotifier,
  redirect:(context, state) {
    final isLoggedIn = SupabaseService.currentSession != null;
    final objectif = state.uri.path;
    final allowedBefore = (objectif == '/signin') || (objectif == '/signup') || (objectif == '/callback');

    if (objectif == '/'){
      return isLoggedIn ? "/catalogue" : "/signin";
    }
    if (!isLoggedIn && !allowedBefore) {
      return '/signin';
    }

    if (isLoggedIn && allowedBefore){
      return "/catalogue"; //mbola ovaina
    }

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AuthPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/signin',
          builder: (context, state) {
            return SignInPage();
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return SignUpPage();
          },
        ),
        GoRoute(
          path: '/callback',
          builder:(context, state) => const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Chargement ..."),
                  AppLoading()
                ],
              ),
            ),
          ),
        )
      ],
    ),

    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          title: _titleFromPath(state.matchedLocation),
          child: child
          );
      },
      routes: _buildRoutes()
    ),
  ],
);

const routeSimple = {
  '/catalogue':'Catalogue',
  '/mes-tickets':'Mes Tickets',
  '/mes-affectations':'Mes Affectations',
};

const routeTechnicien = {
  '/tickets-zone':'Tickets Zone',
  '/historique':'Historique'
};

const routeAdmin = {
  '/dashboard':'Dashboard',
  '/affectations':'Affectations',
  '/materiels':'Matériels',
  '/utilisateurs':'Utilisateurs',
  '/zones':'Zones',
  '/stocks':'Stocks'
};

const otherRoute = {

};
String _titleFromPath(String path) {
  return routeSimple[path] ?? (routeTechnicien[path] ?? (routeAdmin[path]?? 'Materelia'));
}

List<RouteBase> _buildRoutes() {
  return [
    GoRoute(path: '/catalogue',       builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/panier',          builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/mes-tickets',     builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/mes-affectations',builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/profil',          builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/tickets-zone',  builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/historique',    builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/dashboard',     builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/affectations',  builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/materiels',     builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/utilisateurs',  builder: (c, s) => const Text("ovao")),
    GoRoute(path: '/zones',         builder: (c, s) => const Text("ovao")),
    GoRoute(path: "/stocks",        builder: (c, s) => const Text("ovao")), 
    GoRoute(path: "/mon-profile",        builder: (c, s) => const Text("ovao")), 
    ];
}

const routeList = [
  '/catalogue',
  '/mes-tickets',
  '/mes-affectations',
  '/tickets-zone',
  '/historique',
  '/dashboard',
  '/affectations',
  '/materiels',
  '/utilisateurs',
  '/zones',
  '/stocks',
  '/mon-profile'
];