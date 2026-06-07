import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:materelia/features/auth/auth_page.dart";
import "package:materelia/features/auth/signin_page.dart";
import "package:materelia/features/auth/signup_page.dart";
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
      return isLoggedIn ? "/user" : "/signin";
    }
    if (!isLoggedIn && !allowedBefore) {
      return '/signin';
    }

    if (isLoggedIn && allowedBefore){
      return "/user"; //mbola ovaina
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
  ],
);