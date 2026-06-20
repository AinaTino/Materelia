import 'package:materelia/features/profile/service/profile_service.dart';
import 'package:materelia/shared/models/gerer.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/models/zone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
ProfileService profileService(Ref ref) {
  return ProfileService();
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<Utilisateur> build() {
    return ref.read(profileServiceProvider).getCurrentUserProfile();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(profileServiceProvider).getCurrentUserProfile(),
    );
  }

  Future<void> updateProfil({
    required String nom,
    required String prenom,
  }) async {
    final updated = await ref
        .read(profileServiceProvider)
        .updateProfil(nom: nom, prenom: prenom);
    state = AsyncData(updated);
  }
}

// ─── Anciens providers conservés pour compatibilité ────────────────────────

@riverpod
Future<Gerer?> zoneGeree(Ref ref) {
  return ref.read(profileServiceProvider).getZoneGeree();
}

@riverpod
Future<Zone> zoneById(Ref ref, String idZone) {
  return ref.read(profileServiceProvider).getZoneById(idZone);
}

// ─── Nouveau provider multi-zones ──────────────────────────────────────────

@riverpod
Future<List<ZoneAvecStocks>> zonesAvecStocks(Ref ref) {
  return ref.read(profileServiceProvider).getZonesAvecStocks();
}