import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/shared/models/categorie.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class MesDemandesService {
  final _db = SupabaseService.client;

  Future<List<DemandeAffectation>> listDemandes() async {
    final data = await _db
        .from('demandes_affectation')
        .select()
        .eq('id_demandeur', SupabaseService.currentUser!.id)
        .order('date_demande', ascending: false);
    return (data as List).map((e) => DemandeAffectation.fromJson(e)).toList();
  }

  Future<DemandeAffectation> creerDemande({
    required String justification,
    required String serviceBeneficiaire,
    required String idCategorie,
  }) async {
    final data = await _db
        .from("demandes_affectation")
        .insert({
          "justification": justification,
          "service_beneficiaire": serviceBeneficiaire,
          "id_demandeur": SupabaseService.currentUser!.id,
          "id_categorie": idCategorie,
        })
        .select()
        .single();
    return DemandeAffectation.fromJson(data);
  }

  Future<void> supprimerDemande({required String idDemande}) async {
    await _db.from("demandes_affectation").delete().eq("id_demande", idDemande);
  }

  Future<List<Categorie>> listeCategorieDispo() async {
    final data = await _db
        .from("categories")
        .select('*, materiels!inner(etat)')
        .eq("materiels.etat", AppConstants.etatEnStock);
    return (data as List).map((e) => Categorie.fromJson(e)).toList();
  }
}
