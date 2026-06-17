import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/ticket/provider/ticket_provider.dart';
import '../service/panier_service.dart';

final panierServiceProvider = Provider((ref) => PanierService());

class PanierState {
  final List<Map<String, dynamic>> lignes; // chaque ligne : {id_categorie, nom, quantite}
  const PanierState({this.lignes = const []});
}

final panierProvider = NotifierProvider<PanierNotifier, PanierState>(() => PanierNotifier());

class PanierNotifier extends Notifier<PanierState> {
  @override
  PanierState build() => const PanierState();

  /// Ajoute une catégorie avec une quantité (défaut 1)
  void addCategorie(String idCategorie, String nom, {int quantite = 1}) {
    final current = state;
    final existingIndex = current.lignes.indexWhere(
      (l) => l['id_categorie']?.toString() == idCategorie,
    );
    if (existingIndex >= 0) {
      final newList = [...current.lignes];
      newList[existingIndex] = {
        ...newList[existingIndex],
        'quantite': (newList[existingIndex]['quantite'] ?? 0) + quantite,
      };
      state = PanierState(lignes: newList);
    } else {
      state = PanierState(lignes: [
        ...current.lignes,
        {'id_categorie': idCategorie, 'nom': nom, 'quantite': quantite},
      ]);
    }
  }

  /// Supprime une catégorie du panier
  void removeCategorie(String idCategorie) {
    state = PanierState(
      lignes: state.lignes.where((l) => l['id_categorie']?.toString() != idCategorie).toList(),
    );
  }

  void clear() {
    state = const PanierState(lignes: []);
  }
}

// Le provider de catégories disponibles est inchangé
final categoriesDisponiblesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(panierServiceProvider);
  return service.fetchCategoriesDisponibles();
});

// Le notifier d'action (validation)
class PanierActionNotifier extends AsyncNotifier<dynamic> {
  PanierService get _service => ref.read(panierServiceProvider);

  @override
  FutureOr<dynamic> build() => null;

  Future<dynamic> validatePanier({
    List<Map<String, dynamic>>? panier,
    required String userId,
    required String lieu,
    required DateTime dateFin,
  }) async {
    state = const AsyncValue.loading();
    try {
      final currentPanier = panier ?? ref.read(panierProvider).lignes;
      if (currentPanier.isEmpty) {
        throw Exception('Le panier est vide. Veuillez ajouter des catégories.');
      }

      // Construire le payload (id_categorie, nombre)
      final categoriesCount = <String, int>{};
      for (final ligne in currentPanier) {
        final catId = ligne['id_categorie']?.toString();
        if (catId != null) {
          categoriesCount[catId] = (categoriesCount[catId] ?? 0) + (ligne['quantite'] as int? ?? 1);
        }
      }
      if (categoriesCount.isEmpty) {
        throw Exception('Aucune catégorie valide dans le panier.');
      }

      final payloadLignes = categoriesCount.entries
          .map((e) => {'categorie_id': e.key, 'nombre': e.value})
          .toList();

      // Afficher le payload pour debug
      print('=== PAYLOAD ENVOYÉ À L\'EDGE FUNCTION ===');
      print(payloadLignes);

      final res = await _service.validatePanier(
        payloadLignes,
        userId,
        lieu,
        dateFin,
      );

      print('=== RÉPONSE DE L\'EDGE FUNCTION ===');
      print(res);

      if (res == null) {
        throw Exception('Erreur serveur : pas de réponse de l\'Edge Function');
      }

      final ticketsCreated = res['tickets_crees'] as List<dynamic>? ?? [];
      final lignesRetirees = res['lignes_retirees'] as List<dynamic>? ?? [];

      if (ticketsCreated.isEmpty) {
        // Message d'erreur détaillé
        String errorMsg = 'Aucun ticket créé.';
        if (lignesRetirees.isNotEmpty) {
          errorMsg += ' Matériels indisponibles pour : ${lignesRetirees.join(", ")}';
        } else {
          errorMsg += ' Aucun matériel disponible pour les catégories sélectionnées.';
        }
        throw Exception(errorMsg);
      }

      // Vider le panier local
      ref.read(panierProvider.notifier).clear();
      // Invalider les catégories disponibles
      ref.invalidate(categoriesDisponiblesProvider);
      // Invalider les tickets de l'utilisateur
      ref.invalidate(ticketsUserProvider(userId));

      state = AsyncValue.data(res);
      return res;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final panierActionProvider = AsyncNotifierProvider<PanierActionNotifier, dynamic>(() => PanierActionNotifier());