import 'package:materelia/features/mes_demandes/provider/mes_demandes_provider.dart';
import 'package:materelia/shared/models/categorie.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_provider.g.dart';

@riverpod
Future<List<Categorie>> categoriesDisponibles(Ref ref) {
  return ref.read(mesDemandesServiceProvider).listeCategorieDispo();
}

@riverpod
DemandeAffectation? demandeById(Ref ref, String id) {
  final liste = ref.watch(mesDemandesControllerProvider).value;
  return liste?.firstWhere((e) => e.id == id);
}
