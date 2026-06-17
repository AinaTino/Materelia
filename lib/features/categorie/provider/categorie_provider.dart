import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/categorie_service.dart';

final categorieServiceProvider = Provider((ref) => CategorieService());

final categoriesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final svc = ref.read(categorieServiceProvider);
  return svc.fetchCategories();
});

class CategorieCrudNotifier extends AsyncNotifier<void> {
  CategorieService get _service => ref.read(categorieServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.createCategorie(data);
      ref.invalidate(categoriesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateCategorie(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.updateCategorie(id, data);
      ref.invalidate(categoriesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteCategorie(id);
      ref.invalidate(categoriesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final categorieCrudProvider = AsyncNotifierProvider<CategorieCrudNotifier, void>(() => CategorieCrudNotifier());
