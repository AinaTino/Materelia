import 'package:materelia/features/demandes_affectations/provider/other_provider.dart';
import 'package:materelia/features/demandes_affectations/service/demandes_affectations_service.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "demandes_affectations_provider.g.dart";

@riverpod
DemandesAffectationsService demandesAffectationsService(Ref ref) {
  return DemandesAffectationsService();
}

// Un state séparé pour les actions mutantes
@riverpod
class DemandesAffectationsController extends _$DemandesAffectationsController {
  @override
  Future<List<DemandeAffectation>> build() async {
    return ref.read(demandesAffectationsServiceProvider).listDemandes();
  }

  Future<void> refresh() async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(demandesAffectationsServiceProvider).listDemandes();
    });
  }

  Future<void> validerDemande({
    required String idMateriel,
    required String idDemande,
  }) async {
    try {
      await ref
          .read(demandesAffectationsServiceProvider)
          .validerDemande(idDemande: idDemande, idMateriel: idMateriel);
      ref.invalidate(materielsDisponiblesProvider);
      ref.invalidateSelf();
      await future;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refuserDemande({
    required String idDemande,
    required String motif,
  }) async {
    try {
      await ref
          .read(demandesAffectationsServiceProvider)
          .refuserDemande(idDemande: idDemande, motif: motif);
      ref.invalidate(materielsDisponiblesProvider);
      ref.invalidateSelf();
      await future;
    } catch (e) {
      rethrow;
    }
  }
}
