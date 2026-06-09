import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class ProfileService {
  Future<Utilisateur> getCurrentUserProfile() async {
    final userId = SupabaseService.client.auth.currentUser!.id;

    final response = await SupabaseService.client
          .from("utilisateurs")
          .select()
          .eq('id_utilisateur',userId)
          .single();
    return Utilisateur.fromJson(response);
  }
}