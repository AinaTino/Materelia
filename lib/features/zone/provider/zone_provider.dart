import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/zone_service.dart';

final zoneServiceProvider = Provider((ref) => ZoneService());

final zonesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final svc = ref.read(zoneServiceProvider);
  return svc.fetchZones();
});

class ZoneCrudNotifier extends AsyncNotifier<void> {
  ZoneService get _service => ref.read(zoneServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.createZone(data);
      ref.invalidate(zonesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateZone(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await _service.updateZone(id, data);
      ref.invalidate(zonesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    try {
      await _service.deleteZone(id);
      ref.invalidate(zonesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final zoneCrudProvider = AsyncNotifierProvider<ZoneCrudNotifier, void>(() => ZoneCrudNotifier());
