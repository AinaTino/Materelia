import "package:go_router/go_router.dart";

final rootRouter = GoRouter(
  redirect:(context, state) {
    final isLoggedIn = false; // Replace with actual authentication check
    final goingToLogin = state.uri.path == '/login';

    if (!isLoggedIn && !goingToLogin) {
      return '/login';
    }
    if (isLoggedIn && goingToLogin) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/'
    )
  ],
);