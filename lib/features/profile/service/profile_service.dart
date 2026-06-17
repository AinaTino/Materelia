import 'package:materelia/shared/models/gerer.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/models/zone.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class ProfileService {
  final _db = SupabaseService.client;

  Future<Utilisateur> getCurrentUserProfile() async {
    final userId = _db.auth.currentUser!.id;
    final response = await _db
        .from("utilisateurs")
        .select()
        .eq('id_utilisateur', userId)
        .single();
    return Utilisateur.fromJson(response);
  }

  Future<Utilisateur> updateProfil({
    required String nom,
    required String prenom,
  }) async {
    final userId = _db.auth.currentUser!.id;
    final data = await _db
        .from('utilisateurs')
        .update({'nom': nom, 'prenom': prenom})
        .eq('id_utilisateur', userId)
        .select()
        .single();
    return Utilisateur.fromJson(data);
  }

  Future<Gerer?> getZoneGeree() async {
    final userId = _db.auth.currentUser!.id;
    final data = await _db
        .from('gerer')
        .select()
        .eq('id_utilisateur', userId)
        .maybeSingle();
    if (data == null) return null;
    return Gerer.fromJson(data);
  }

  Future<Zone> getZoneById(String idZone) async {
    final data = await _db
        .from('zones')
        .select()
        .eq('id_zone', idZone)
        .single();
    return Zone.fromJson(data);
  }
}
