import 'package:flutter/material.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/shared/models/affectation.dart';
import 'package:materelia/shared/models/categorie.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/models/materiel.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/services/supabase_service.dart';

class AffectationListItem {
  final Affectation affectation;
  final Categorie categorie;
  final Utilisateur beneficiaire;

  const AffectationListItem({
    required this.affectation,
    required this.categorie,
    required this.beneficiaire,
  });
}

class AffectationDetail {
  final Affectation affectation;
  final Materiel materiel;
  final Categorie categorie;
  final DemandeAffectation demande;
  final Utilisateur beneficiaire;

  const AffectationDetail({
    required this.affectation,
    required this.materiel,
    required this.categorie,
    required this.demande,
    required this.beneficiaire,
  });
}

class AffectationsService {
  static final _db = SupabaseService.client;

  Future<List<AffectationListItem>> listAffectations() async {
    final data = await _db
        .from('affectations')
        .select(
          '*, materiels(*, categories(*)), utilisateurs!id_beneficiaire(*)',
        )
        .order('date_debut', ascending: false);

    final items = <AffectationListItem>[];
    for (final e in data as List) {
      try {
        final affectation = Affectation.fromJson(e as Map<String, dynamic>);
        final materielJson = e['materiels'] as Map<String, dynamic>?;
        final categorieJson =
            materielJson?['categories'] as Map<String, dynamic>?;
        final userJson = e['utilisateurs'] as Map<String, dynamic>?;

        if (materielJson == null || categorieJson == null || userJson == null) {
          continue;
        }

        items.add(
          AffectationListItem(
            affectation: affectation,
            categorie: Categorie.fromJson(categorieJson),
            beneficiaire: Utilisateur.fromJson(userJson),
          ),
        );
      } catch (err) {
        debugPrint('Erreur listAffectations: $e\n$err');
      }
    }
    return items;
  }

  Future<AffectationDetail> fetchAffectation(String id) async {
    final data = await _db
        .from('affectations')
        .select(
          '*, materiels(*, categories(*)), demandes_affectation(*), utilisateurs!id_beneficiaire(*)',
        )
        .eq('id_affectation', id)
        .single();

    final materielJson = data['materiels'] as Map<String, dynamic>;
    final categorieJson = materielJson['categories'] as Map<String, dynamic>;
    final demandeJson = data['demandes_affectation'] as Map<String, dynamic>;
    final userJson = data['utilisateurs'] as Map<String, dynamic>;

    return AffectationDetail(
      affectation: Affectation.fromJson(data),
      materiel: Materiel.fromJson(materielJson),
      categorie: Categorie.fromJson(categorieJson),
      demande: DemandeAffectation.fromJson(demandeJson),
      beneficiaire: Utilisateur.fromJson(userJson),
    );
  }

  /// Révocation définitive
  Future<void> revoquerAffectation(String id) async {
    await _db
        .from('affectations')
        .update({
          'etat': AppConstants.affectationRevoquee,
          'date_fin_effective': DateTime.now().toIso8601String(),
        })
        .eq('id_affectation', id);
  }

  /// Renouvellement : dateFinPrevue actuelle + dureeAffectationJours
  Future<void> renouvelerAffectation(
    String id,
    DateTime dateFinActuelle,
  ) async {
    final nouvelleFin = dateFinActuelle.add(
      Duration(days: AppConstants.dureeAffectationJours),
    );
    await _db
        .from('affectations')
        .update({'date_fin_prevue': nouvelleFin.toIso8601String()})
        .eq('id_affectation', id);
  }
}
