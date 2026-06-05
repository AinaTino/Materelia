import "package:go_router/go_router.dart";
import "package:materelia/features/home/homepage.dart";
import "package:materelia/shared/services/supabase_service.dart";

final rootRouter = GoRouter(
  redirect:(context, state) {
    final isLoggedIn = SupabaseService.currentUser != null;
    final objectif = state.uri.path;
    final allowedBefore = (objectif == '/signin') || (objectif == '/signup') ;

    if (!isLoggedIn && !allowedBefore) {
      return '/signin';
    }

    if (isLoggedIn && allowedBefore){
      return "/"; //mbola ovaina
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/', 
      builder:(context, state) => HomePage(),
    ),
  ],
);