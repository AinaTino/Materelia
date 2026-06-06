import 'package:supabase_flutter/supabase_flutter.dart';

import '../../shared/services/supabase_service.dart';

class AuthService {
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return SupabaseService.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

   Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
  }) {
    return SupabaseService.client.auth.signUp(
      email: email,
      password: password,
      data: {
        'nom': nom,
        'prenom': prenom,
      },
    );
  }

  Future<void> signOut() async {
    await SupabaseService.client.auth.signOut();
  }
}