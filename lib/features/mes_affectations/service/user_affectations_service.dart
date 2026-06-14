import 'package:materelia/shared/models/affectation.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class UserAffectationsController {
   static final _db = SupabaseService.client;

  static Future<List<Affectation>> listAffectations() async {
    final data = await _db
        .from('affectations')
        .select()
        .eq('id_beneficiaire', SupabaseService.currentUser!.id)
        .order('date_debut', ascending: false);
    return (data as List).map((e) => Affectation.fromJson(e)).toList();
  }

  static Future<Affectation> fetchAffectation(String id) async {
    final data = await _db
        .from('affectations')
        .select()
        .eq('id_affectation', id)
        .single();
    return Affectation.fromJson(data);
  }

  static Future<void> revoquerAffectation(String id) async {
    await _db.from('affectations').update({
      'etat': 'REVOQUEE',
      'date_fin_effective': DateTime.now().toIso8601String(),
    }).eq('id_affectation', id);
  }

  static Future<void> renouvelerAffectation(String id) async {
    final aff = await fetchAffectation(id);
    final nouvelleFin = aff.dateFinPrevue.add(const Duration(days: 90));
    await _db.from('affectations').update({
      'etat': 'ACTIVE',
      'date_fin_prevue': nouvelleFin.toIso8601String(),
      'date_fin_effective': null,
    }).eq('id_affectation', id);
  }

}
