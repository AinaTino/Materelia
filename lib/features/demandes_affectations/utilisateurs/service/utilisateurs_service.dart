import 'package:materelia/features/notifications/service/notifications_service.dart';
import 'package:materelia/shared/models/gerer.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/models/zone.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class UtilisateursService {
  final _db = SupabaseService.client;

  Future<List<Utilisateur>> listUtilisateurs() async {
    final data = await _db
        .from('utilisateurs')
        .select()
        .order('nom', ascending: true);
    return (data as List).map((e) => Utilisateur.fromJson(e)).toList();
  }

  Future<void> changerRole({
    required String idUtilisateur,
    required String nouveauRole,
  }) async {
    await _db
        .from('utilisateurs')
        .update({'role': nouveauRole})
        .eq('id_utilisateur', idUtilisateur);

    final label = switch (nouveauRole) {
      'ADMIN' => 'Administrateur',
      'TECHNICIEN' => 'Technicien',
      _ => 'Simple utilisateur',
    };

    await NotificationsService().envoyerNotif(
      idUtilisateur: idUtilisateur,
      message: 'Votre rôle a été mis à jour : $label.',
      type: 'ALERTE',
      route: null,
    );
  }

  Future<void> supprimerUtilisateur({required String idUtilisateur}) async {
    await _db.from('utilisateurs').delete().eq('id_utilisateur', idUtilisateur);
  }

  Future<List<Zone>> listZones() async {
    final data = await _db.from('zones').select().order('nom', ascending: true);
    return (data as List).map((e) => Zone.fromJson(e)).toList();
  }

  Future<Gerer?> getZoneTechnicien({required String idUtilisateur}) async {
    final data = await _db
        .from('gerer')
        .select()
        .eq('id_utilisateur', idUtilisateur)
        .maybeSingle();
    if (data == null) return null;
    return Gerer.fromJson(data);
  }

  Future<void> assignerZone({
    required String idUtilisateur,
    required String idZone,
  }) async {
    await _db.from('gerer').upsert({
      'id_utilisateur': idUtilisateur,
      'id_zone': idZone,
    });
  }

  Future<void> retirerZone({required String idUtilisateur}) async {
    await _db.from('gerer').delete().eq('id_utilisateur', idUtilisateur);
  }
}
