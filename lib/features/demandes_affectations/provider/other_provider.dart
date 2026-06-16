import 'package:materelia/features/demandes_affectations/provider/demandes_affectations_provider.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/models/materiel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_provider.g.dart';

@riverpod
Future<List<Materiel>> materielsDisponibles(Ref ref, String idCategorie) {
  return ref
      .read(demandesAffectationsServiceProvider)
      .listeMaterielsDispo(idCategorie: idCategorie);
}

@riverpod
DemandeAffectation? demandeById(Ref ref, String id) {
  final liste = ref.watch(demandesAffectationsControllerProvider).value;
  return liste?.firstWhere((e) => e.id == id);
}
