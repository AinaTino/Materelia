import 'dart:core';

import 'package:materelia/features/mes_demandes/service/mes_demandes_service.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "mes_demandes_provider.g.dart";

@riverpod
MesDemandesService mesDemandesService(Ref ref) {
  return MesDemandesService();
}

@riverpod
class MesDemandesController extends _$MesDemandesController {
  @override
  Future<List<DemandeAffectation>> build() async {
    return ref.read(mesDemandesServiceProvider).listDemandes();
  }

  Future<void> refresh() async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(mesDemandesServiceProvider).listDemandes();
    });
  }

  Future<DemandeAffectation> creerDemande({
    required String justification,
    required String serviceBeneficiaire,
    required String idCategorie,
  }) async {
    final current = state.value ?? [];
    try {
      final nouvelle = await ref
          .read(mesDemandesServiceProvider)
          .creerDemande(
            justification: justification,
            serviceBeneficiaire: serviceBeneficiaire,
            idCategorie: idCategorie,
          );

      state = AsyncData([nouvelle, ...current]);
      return nouvelle;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> supprimerDemande({required String idDemande}) async {
    final current = state.value ?? [];
    try {
      await ref
          .read(mesDemandesServiceProvider)
          .supprimerDemande(idDemande: idDemande);
      state = AsyncData(current.where((e) => e.id != idDemande).toList());
    } catch (_) {
      rethrow;
    }
  }
}
