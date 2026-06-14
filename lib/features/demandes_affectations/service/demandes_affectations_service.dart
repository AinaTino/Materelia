
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

  Future<DemandeAffectation> creerDemande({
    required String justification,
    required String serviceBeneficiaire,
    required String idCategorie,
  }) async {
    final data = await _db.from('demandes_affectation').insert({
      'id_demandeur': SupabaseService.currentUser!.id,
      'justification': justification,
      'service_beneficiaire': serviceBeneficiaire,
      'id_categorie': idCategorie,
      'etat': 'EN_ATTENTE',
    })
    .select()
    .single();
    return DemandeAffectation.fromJson(data);
  }

  Future<void> validerDemande({
    required String idDemande,
    required String idMateriel,
    required DateTime dateDebut,
    required DateTime dateFinPrevue,
    required String idBeneficiaire,
  }) async {

    await _db.from('affectations').insert({
      'id_materiel': idMateriel,
      'id_beneficiaire': idBeneficiaire,
      'id_demande': idDemande,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin_prevue': dateFinPrevue.toIso8601String(),
      'etat': 'ACTIVE',
    });

    await _db.from('demandes_affectation').update({
      'etat': 'VALIDE',
      'id_valideur': SupabaseService.currentUser!.id,
    }).eq('id_demande', idDemande);

    await _db
        .from('materiels')
        .update({'etat': 'AFFECTE'}).eq('id_materiel', idMateriel);
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