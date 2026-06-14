
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class DemandesAffectationsService {
   final _db = SupabaseService.client;

  Future<List<DemandeAffectation>> listDemandes() async {
    final data = await _db
        .from('demandes_affectation')
        .select()
        .order('date_demande', ascending: false);
    return (data as List).map((e) => DemandeAffectation.fromJson(e)).toList();
  }

  Future<void> validerDemande({
    required String idDemande,
    required String idMateriel,
  }) async {

    final d = await _db.from('demandes_affectation').update({
      'etat': 'VALIDE',
      'id_valideur': SupabaseService.currentUser!.id,
    }).eq('id_demande', idDemande)
    .select()
    .single();

    final demande = DemandeAffectation.fromJson(d);

    await _db
        .from('materiels')
        .update({'etat': 'AFFECTE'}).eq('id_materiel', idMateriel);

    await _db.from('affectations').insert({
      'id_materiel': idMateriel,
      'id_beneficiaire': demande.idDemandeur,
      'id_demande': idDemande,
      'date_debut': demande.dateDebut?.toIso8601String(),
      'date_fin_prevue': demande.dateFinPrevue?.toIso8601String(),
      'etat': 'ACTIVE',
    });

  }

  Future<void> refuserDemande({
    required String idDemande,
    required String motif,
  }) async {
    await _db.from('demandes_affectation').update({
      'etat': 'REFUSE',
      'motif_refus': motif,
      'id_valideur': SupabaseService.currentUser!.id,
    }).eq('id_demande', idDemande);
  }
}