import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/ticket_service.dart';

final ticketServiceProvider = Provider((ref) => TicketService());

// ===================== FETCH PROVIDERS =====================

final ticketsUserProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketsForUser(userId);
});

final ticketsZoneProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, zoneId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketsForZone(zoneId);
});

final ticketDetailProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, ticketId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketDetail(ticketId);
});

final technicienZonesProvider = FutureProvider.autoDispose.family<List<String>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchZonesForTechnicien(userId);
});

final ticketsTechnicienProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  final zones = await service.fetchZonesForTechnicien(userId);
  if (zones.isEmpty) return [];
  final results = await Future.wait(zones.map((z) => service.fetchTicketsForZone(z)));
  final all = results.expand((l) => l).toList();
  return all;
});

// ===================== CATEGORIES & MATERIELS =====================

final ticketCategoriesProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, ticketId) async {
  final service = ref.read(ticketServiceProvider);
  return service.getCategoriesDemandees(ticketId);
});

final ticketMaterielsRemisProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, ticketId) async {
  final service = ref.read(ticketServiceProvider);
  return service.getMaterielsRemis(ticketId);
});

final materielsDisponiblesPourCategorieProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, String>((ref, categorieId) async {
  final service = ref.read(ticketServiceProvider);
  return service.getMaterielsDisponiblesPourCategorie(categorieId);
});

// ===================== NOTIFIER ACTIONS =====================

class TicketActionNotifier extends AsyncNotifier<void> {
  TicketService get _service => ref.read(ticketServiceProvider);

  @override
  FutureOr<void> build() async {}

  Future<void> confirmerRemiseAvecMateriels({
    required String code,
    required String technicienId,
    required List<String> materielIds,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _service.confirmerRemiseAvecMateriels(
        code: code,
        technicienId: technicienId,
        materielIds: materielIds,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> confirmerRetourParCode(String code, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.confirmerRetourParCode(code, technicienId);
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final ticketActionProvider = AsyncNotifierProvider<TicketActionNotifier, void>(() => TicketActionNotifier());