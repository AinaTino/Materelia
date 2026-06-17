import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/ticket_service.dart';

final ticketServiceProvider = Provider((ref) => TicketService());

// ── PROVIDERS FETCH ──────────────────────────────────────────────────────────

/// Tickets pour un utilisateur Simple
final ticketsUserProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketsForUser(userId);
});

/// Tickets pour une zone (Technicien)
final ticketsZoneProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, zoneId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketsForZone(zoneId);
});

/// Détail complet d'un ticket (+ lignes + matériels)
final ticketDetailProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, ticketId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchTicketDetail(ticketId);
});

/// Zones gérées par un technicien (liste d'IDs)
final technicienZonesProvider = FutureProvider.autoDispose.family<List<String>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  return service.fetchZonesForTechnicien(userId);
});

/// Tous les tickets de toutes les zones d'un technicien (agrégés)
final ticketsTechnicienProvider = FutureProvider.autoDispose.family<List<dynamic>, String>((ref, userId) async {
  final service = ref.read(ticketServiceProvider);
  final zones = await service.fetchZonesForTechnicien(userId);
  if (zones.isEmpty) return [];
  final results = await Future.wait(zones.map((z) => service.fetchTicketsForZone(z)));
  // Aplatir et dédupliquer
  final all = results.expand((l) => l).toList();
  return all;
});

// ── NOTIFIER ACTIONS ─────────────────────────────────────────────────────────

class TicketActionNotifier extends AsyncNotifier<void> {
  TicketService get _service => ref.read(ticketServiceProvider);

  @override
  FutureOr<void> build() async {}

  Future<void> validateTicket(String ticketId, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.validateTicket(ticketId, technicienId);
      ref.invalidate(ticketDetailProvider(ticketId));
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> refuseTicket(String ticketId, String motif, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.refuseTicket(ticketId, motif, technicienId);
      ref.invalidate(ticketDetailProvider(ticketId));
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// NOUVELLE ACTION : Confirmer la remise physique avec code
  Future<void> confirmerRemise(String ticketId, String code, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.confirmerRemise(ticketId, code, technicienId);
      ref.invalidate(ticketDetailProvider(ticketId));
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> confirmReturn(String ticketId, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.confirmReturn(ticketId, technicienId);
      ref.invalidate(ticketDetailProvider(ticketId));
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  // Ajouter la nouvelle action
  Future<void> confirmerRemiseParCode(String code, String technicienId, {String? userId, String? zoneId}) async {
    state = const AsyncValue.loading();
    try {
      await _service.confirmerRemiseParCode(code, technicienId);
      // Invalider les providers (on ne sait pas quel ticket, on invalide tout)
      if (userId != null) ref.invalidate(ticketsUserProvider(userId));
      if (zoneId != null) ref.invalidate(ticketsZoneProvider(zoneId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  /// Confirmer le retour physique par code de remise
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