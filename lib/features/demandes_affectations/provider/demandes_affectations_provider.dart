import 'package:materelia/features/demandes_affectations/service/demandes_affectations_service.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "demandes_affectations_provider.g.dart";

@riverpod
DemandesAffectationsService demandesAffectationsService(Ref ref) {
  return DemandesAffectationsService();
}

@riverpod 
class DemandesAffectationsController extends _$DemandesAffectationsController {
  @override
  Future<List<DemandeAffectation>> build() async{
    return ref.read(demandesAffectationsServiceProvider).listDemandes();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      ref.read(demandesAffectationsServiceProvider).listDemandes,
    );
  }

  Future<void> creerDemande({
    required String justification,
    required String serviceBeneficiaire,
    required String idCategorie,
  }) async{
    ref.read(demandesAffectationsServiceProvider).creerDemande(justification: justification, serviceBeneficiaire: serviceBeneficiaire, idCategorie: idCategorie);
  }
}