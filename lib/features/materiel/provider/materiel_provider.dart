import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/shared/services/supabase_service.dart';
import '../service/materiel_service.dart';

final materielServiceProvider = Provider((ref) => MaterielService());

// ✅ Utiliser un NotifierProvider pour les filtres (compatible avec toutes les versions)
class MaterielFiltersNotifier extends Notifier<Map<String, dynamic>?> {
  @override
  Map<String, dynamic>? build() {
    return null;
  }

  void setFilters(Map<String, dynamic>? filters) {
    state = filters;
  }
}

final materielFiltersProvider = NotifierProvider<MaterielFiltersNotifier, Map<String, dynamic>?>(() {
  return MaterielFiltersNotifier();
});

// ✅ Utiliser un provider qui lit les filtres
final materielsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final filters = ref.watch(materielFiltersProvider);
  final svc = ref.read(materielServiceProvider);
  return svc.fetchMateriels(filters: filters);
});

/// Détail d'un matériel
final materielDetailProvider = FutureProvider.autoDispose.family<Map<String, dynamic>?, String>((ref, id) async {
  final svc = ref.read(materielServiceProvider);
  return svc.fetchMaterielDetail(id);
});

/// Catégories (toutes)
final categoriesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final res = await SupabaseService.client.from('categories').select().order('nom', ascending: true);
  final data = (res as List<dynamic>?) ?? [];
  return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
});

/// Stocks (tous)
final stocksProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final res = await SupabaseService.client.from('stocks').select().order('nom', ascending: true);
  final data = (res as List<dynamic>?) ?? [];
  return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
});

/// Notifier pour les opérations CRUD sur Matériel
class MaterielCrudNotifier extends AsyncNotifier<void> {
  MaterielService get _service => ref.read(materielServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.createMateriel(data);
      ref.invalidate(materielsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateMateriel(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.updateMateriel(id, data);
      ref.invalidate(materielDetailProvider(id));
      ref.invalidate(materielsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> reform(String id) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteMateriel(id, hardDelete: false);
      ref.invalidate(materielDetailProvider(id));
      ref.invalidate(materielsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final materielCrudProvider = AsyncNotifierProvider<MaterielCrudNotifier, void>(() => MaterielCrudNotifier());