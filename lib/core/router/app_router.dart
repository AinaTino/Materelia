import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:materelia/core/shell/app_shell.dart";
import "package:materelia/features/affectations/UI/affectations_page.dart";
import "package:materelia/features/auth/UI/auth_page.dart";
import "package:materelia/features/auth/UI/signin_page.dart";
import "package:materelia/features/auth/UI/signup_page.dart";
import "package:materelia/features/dashboard/UI/dashboard_page.dart";
import "package:materelia/features/demandes_affectations/UI/demandes_affectations_page.dart";
import "package:materelia/features/demandes_affectations/utilisateurs/UI/utilisateurs_page.dart";
import "package:materelia/features/mes_affectations/UI/mes_affectations_page.dart";
import "package:materelia/features/mes_demandes/UI/mes_demandes_page.dart";
import "package:materelia/features/notifications/UI/notifications_page.dart";
import "package:materelia/features/profile/UI/profile_page.dart";
import "package:materelia/features/panier/UI/panier_page.dart";
import "package:materelia/features/panier/UI/panier_recap_page.dart";
import "package:materelia/features/ticket/UI/ticket_page.dart";
import "package:materelia/features/ticket/UI/tickets_zone_page.dart";
import "package:materelia/features/ticket/UI/historique_page.dart";
import "package:materelia/features/materiel/UI/materiel_page.dart";
import "package:materelia/features/zone/UI/zone_page.dart";
import "package:materelia/features/stock/UI/stock_page.dart";
import "package:materelia/features/categorie/UI/categorie_page.dart";
import "package:materelia/shared/services/auth_notifier.dart";
import "package:materelia/shared/services/supabase_service.dart";
import "package:materelia/shared/widgets/loading.dart";

final authNotifier = AuthNotifier();

final rootRouter = GoRouter(
  refreshListenable: authNotifier,
  redirect: (context, state) {
    final isLoggedIn = SupabaseService.currentSession != null;
    final objectif = state.uri.path;
    final allowedBefore =
        (objectif == '/signin') ||
        (objectif == '/signup') ||
        (objectif == '/callback');

    if (objectif == '/') {
      return isLoggedIn ? "/catalogue" : "/signin";
    }
    if (!isLoggedIn && !allowedBefore) {
      return '/signin';
    }

    if (isLoggedIn && allowedBefore) {
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
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Chargement ..."), AppLoading()],
              ),
            ),
          ),
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          title: _titleFromPath(state.matchedLocation),
          child: child,
        );
      },
      routes: _buildRoutes(),
    ),
  ],
);

const routeSimple = {
  '/catalogue': 'Catalogue',
  '/mes-tickets': 'Mes Tickets',
  '/mes-affectations': 'Mes Affectations',
  '/mes-demandes': 'Mes demandes d\'affectation',
  '/panier':'Panier',
};

const routeTechnicien = {
  '/tickets-zone': 'Tickets Zone',
  '/historique': 'Historique',
};

const routeAdmin = {
  '/dashboard': 'Dashboard',
  '/affectations': 'Affectations',
  '/demandes-affectations': 'Demandes d\'affectations',
  '/materiels': 'Matériels',
  '/utilisateurs': 'Utilisateurs',
  '/zones': 'Zones',
  '/stocks': 'Stocks',
  '/categories':'Catégories',
  '/zones':'Zones',
  '/stocks':'Stocks'
};

const otherRoute = {};
String _titleFromPath(String path) {
  return path == '/mon-profil'
      ? "Mon Profil"
      : (routeSimple[path] ??
            (routeTechnicien[path] ?? (routeAdmin[path] ?? 'Materelia')));
}

List<RouteBase> _buildRoutes() {
  return [
    GoRoute(path: '/catalogue',       builder: (c, s) => const PanierPage()),
    GoRoute(path: '/panier',          builder: (c, s) => const PanierRecapPage()),
    GoRoute(path: '/mes-tickets',     builder: (c, s) => const TicketPage()),
    GoRoute(
      path: '/mes-affectations',
      builder: (c, s) => const MesAffectationsPage(),
    ),
    GoRoute(path: '/mes-demandes', builder: (c, s) => const MesDemandesPage()),
    GoRoute(path: '/tickets-zone',  builder: (c, s) => const TicketsZonePage()),
    GoRoute(path: '/historique',    builder: (c, s) => const HistoriquePage()),
    GoRoute(path: '/dashboard', builder: (c, s) => const DashboardPage()),
    GoRoute(path: '/affectations', builder: (c, s) => const AffectationsPage()),
    GoRoute(
      path: '/demandes-affectations',
      builder: (c, s) => const DemandesAffectationsPage(),
    ),
    GoRoute(path: '/materiels',     builder: (c, s) => const MaterielPage()),
    GoRoute(path: '/categories',    builder: (c, s) => const CategoriePage()),
    GoRoute(path: '/utilisateurs', builder: (c, s) => const UtilisateursPage()),
    GoRoute(path: '/zones',         builder: (c, s) => const ZonePage()),
    GoRoute(path: "/stocks",        builder: (c, s) => const StockPage()), 
    GoRoute(path: "/mon-profil", builder: (c, s) => const ProfilPage()),
    GoRoute(
      path: "/notifications",
      builder: (c, s) => const NotificationsPage(),
    ),
  ];
}

