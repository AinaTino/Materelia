import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/stock_service.dart';

final stockServiceProvider = Provider((ref) => StockService());

final stocksListProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final svc = ref.read(stockServiceProvider);
  return svc.fetchStocks();
});

class StockCrudNotifier extends AsyncNotifier<void> {
  StockService get _service => ref.read(stockServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.createStock(data);
      ref.invalidate(stocksListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateStock(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.updateStock(id, data);
      ref.invalidate(stocksListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteStock(id);
      ref.invalidate(stocksListProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final stockCrudProvider = AsyncNotifierProvider<StockCrudNotifier, void>(() => StockCrudNotifier());
