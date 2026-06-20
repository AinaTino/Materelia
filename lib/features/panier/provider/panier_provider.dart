import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/ticket/provider/ticket_provider.dart';
import '../service/panier_service.dart';

final panierServiceProvider = Provider((ref) => PanierService());

class PanierState {
  final List<Map<String, dynamic>> lignes;
  const PanierState({this.lignes = const []});
}

final panierProvider = NotifierProvider<PanierNotifier, PanierState>(() => PanierNotifier());

class PanierNotifier extends Notifier<PanierState> {
  @override
  PanierState build() => const PanierState();

  bool addCategorie(String idCategorie, String nom, int dispoMax, {int quantite = 1}) {
    final current = state;
    final existingIndex = current.lignes.indexWhere(
      (l) => l['id_categorie']?.toString() == idCategorie,
    );

    int currentQuantite = 0;
    if (existingIndex >= 0) {
      currentQuantite = (current.lignes[existingIndex]['quantite'] as int?) ?? 0;
    }

    final nouvelleQuantite = currentQuantite + quantite;
    if (nouvelleQuantite > dispoMax) {
      return false;
    }

    if (existingIndex >= 0) {
      final newList = [...current.lignes];
      newList[existingIndex] = {
        ...newList[existingIndex],
        'quantite': nouvelleQuantite,
        'dispoMax': dispoMax,
      };
      state = PanierState(lignes: newList);
    } else {
      state = PanierState(lignes: [
        ...current.lignes,
        {'id_categorie': idCategorie, 'nom': nom, 'quantite': quantite, 'dispoMax': dispoMax},
      ]);
    }
    return true;
  }

  void removeCategorie(String idCategorie) {
    state = PanierState(
      lignes: state.lignes.where((l) => l['id_categorie']?.toString() != idCategorie).toList(),
    );
  }

  bool updateQuantite(String idCategorie, int nouvelleQuantite) {
    final current = state;
    final index = current.lignes.indexWhere(
      (l) => l['id_categorie']?.toString() == idCategorie,
    );
    if (index < 0) return false;

    final dispoMax = (current.lignes[index]['dispoMax'] as int?) ?? 0;
    if (nouvelleQuantite < 1 || nouvelleQuantite > dispoMax) {
      return false;
    }

    final newList = [...current.lignes];
    newList[index] = {
      ...newList[index],
      'quantite': nouvelleQuantite,
    };
    state = PanierState(lignes: newList);
    return true;
  }

  void clear() {
    state = const PanierState(lignes: []);
  }
}

final categoriesDisponiblesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final service = ref.read(panierServiceProvider);
  return service.fetchCategoriesDisponibles();
});

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
        throw Exception('Le panier est vide.');
      }

      final categoriesCount = <String, int>{};
      for (final ligne in currentPanier) {
        final catId = ligne['id_categorie']?.toString();
        if (catId != null) {
          categoriesCount[catId] = (categoriesCount[catId] ?? 0) + (ligne['quantite'] as int? ?? 1);
        }
      }

      final payloadLignes = categoriesCount.entries
          .map((e) => {'categorie_id': e.key, 'nombre': e.value})
          .toList();

      final res = await _service.validatePanier(
        payloadLignes,
        userId,
        lieu,
        dateFin,
      );

      if (res == null) {
        throw Exception('Erreur serveur.');
      }

      final ticketsCreated = res['tickets_crees'] as List<dynamic>? ?? [];
      final lignesRetirees = res['lignes_retirees'] as List<dynamic>? ?? [];

      if (ticketsCreated.isEmpty) {
        String errorMsg = 'Aucun ticket créé.';
        if (lignesRetirees.isNotEmpty) {
          errorMsg += ' Matériels indisponibles pour : ${lignesRetirees.join(", ")}';
        }
        throw Exception(errorMsg);
      }

      ref.read(panierProvider.notifier).clear();
      ref.invalidate(categoriesDisponiblesProvider);
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