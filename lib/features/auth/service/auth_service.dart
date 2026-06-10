import 'package:materelia/features/auth/service/auth_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_validation.dart';
import '../../../shared/services/supabase_service.dart';

class AuthService {
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    verifyMail(email);
    verifyPassword(password);
    return SupabaseService.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

   Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String nom,
    required String prenom,
  }) {
    if (password != passwordConfirmation) {
      throw PasswordErrorException("Les mots de passe ne correspondent pas.");
    }
    verifyName(nom);
    verifyFirstName(prenom);
    verifyMail(email);
    verifyPassword(password);
    verifyPassword(passwordConfirmation);
    return SupabaseService.client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'materelia://auth/callback',
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