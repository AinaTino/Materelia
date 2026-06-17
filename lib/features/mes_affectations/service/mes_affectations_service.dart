import 'package:materelia/shared/models/affectation.dart';
import 'package:materelia/shared/models/categorie.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/models/materiel.dart';
import 'package:materelia/shared/services/supabase_service.dart';

/// Données complètes pour un item de la liste
class AffectationListItem {
  final Affectation affectation;
  final Categorie categorie;

  const AffectationListItem({
    required this.affectation,
    required this.categorie,
  });
}

/// Données complètes pour le panneau de détail
class AffectationDetail {
  final Affectation affectation;
  final Materiel materiel;
  final Categorie categorie;
  final DemandeAffectation demande;

  const AffectationDetail({
    required this.affectation,
    required this.materiel,
    required this.categorie,
    required this.demande,
  });
}

class MesAffectationsService {
  static final _db = SupabaseService.client;

  /// Liste avec juste ce qu'il faut pour afficher les tuiles
  Future<List<AffectationListItem>> listAffectations() async {
    final data = await _db
        .from('affectations')
        .select('*, materiels(*, categories(*))')
        .eq('id_beneficiaire', SupabaseService.currentUser!.id)
        .order('date_debut', ascending: false);

    return (data as List).map((e) {
      final affectation = Affectation.fromJson(e);
      final categorieJson =
          e['materiels']['categories'] as Map<String, dynamic>;
      final categorie = Categorie.fromJson(categorieJson);
      return AffectationListItem(
        affectation: affectation,
        categorie: categorie,
      );
    }).toList();
  }

  /// Détail complet d'une affectation
  Future<AffectationDetail> fetchAffectation(String id) async {
    final data = await _db
        .from('affectations')
        .select('*, materiels(*, categories(*)), demandes_affectation(*)')
        .eq('id_beneficiaire', SupabaseService.currentUser!.id)
        .eq('id_affectation', id)
        .single();

    final affectation = Affectation.fromJson(data);
    final materielJson = data['materiels'] as Map<String, dynamic>;
    final materiel = Materiel.fromJson(materielJson);
    final categorieJson = materielJson['categories'] as Map<String, dynamic>;
    final categorie = Categorie.fromJson(categorieJson);
    final demande = DemandeAffectation.fromJson(
      data['demandes_affectation'] as Map<String, dynamic>,
    );

    return AffectationDetail(
      affectation: affectation,
      materiel: materiel,
      categorie: categorie,
      demande: demande,
    );
  }
}

  // Future<void> revoquerAffectation(String id) async {
  //   final ancien = await _db
  //       .from('affectations')
  //       .update({
  //         'etat': 'REVOQUEE',
  //         'date_fin_effective': DateTime.now().toIso8601String(),
  //       })
  //       .eq('id_affectation', id)
  //       .select()
  //       .single();

  //   await _db
  //       .from("materiels")
  //       .update({'etat': AppConstants.etatEnStock})
  //       .eq("id_materiel", ancien["id_materiel"]);
  // }

  // Future<void> renouvelerAffectation(String id) async {
  //   final data = await _db
  //       .from('affectations')
  //       .select()
  //       .eq('id_affectation', id)
  //       .single();
  //   final d = Affectation.fromJson(data);
  //   await _db
  //       .from('affectations')
  //       .update({
  //         'etat': 'ACTIVE',
  //         'date_fin_prevue': d.dateFinPrevue
  //             .add(const Duration(days: 90))
  //             .toIso8601String(),
  //         'date_fin_effective': null,
  //       })
  //       .eq('id_affectation', id);
  // }