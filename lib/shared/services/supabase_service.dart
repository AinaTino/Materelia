
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static User? get currentUser => client.auth.currentUser;

  static Session? get currentSession => client.auth.currentSession;

  static Stream<AuthState> get authStateStream =>
      client.auth.onAuthStateChange;

  static Future<dynamic> callFunction(
    String name, {
    Map<String, dynamic>? body,
  }) async {
    final res = await client.functions.invoke(name, body: body);
    return res.data;
  }
}