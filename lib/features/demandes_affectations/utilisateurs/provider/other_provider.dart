import 'package:materelia/features/demandes_affectations/utilisateurs/provider/utilisateurs_provider.dart';
import 'package:materelia/shared/models/gerer.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/models/zone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_provider.g.dart';

@riverpod
Utilisateur? utilisateurById(Ref ref, String id) {
  final liste = ref.watch(utilisateursControllerProvider).value;
  return liste?.firstWhere((u) => u.id == id);
}

@riverpod
Future<List<Zone>> zonesDisponibles(Ref ref) {
  return ref.read(utilisateursServiceProvider).listZones();
}

@riverpod
Future<Gerer?> zoneTechnicien(Ref ref, String idUtilisateur) {
  return ref
      .read(utilisateursServiceProvider)
      .getZoneTechnicien(idUtilisateur: idUtilisateur);
}
