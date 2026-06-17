import 'package:materelia/features/demandes_affectations/utilisateurs/service/utilisateurs_service.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'utilisateurs_provider.g.dart';

@riverpod
UtilisateursService utilisateursService(Ref ref) {
  return UtilisateursService();
}

@riverpod
class UtilisateursController extends _$UtilisateursController {
  @override
  Future<List<Utilisateur>> build() async {
    return ref.read(utilisateursServiceProvider).listUtilisateurs();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(utilisateursServiceProvider).listUtilisateurs(),
    );
  }

  Future<void> changerRole({
    required String idUtilisateur,
    required String nouveauRole,
  }) async {
    await ref
        .read(utilisateursServiceProvider)
        .changerRole(idUtilisateur: idUtilisateur, nouveauRole: nouveauRole);
    ref.invalidateSelf();
    await future;
  }

  Future<void> supprimerUtilisateur({required String idUtilisateur}) async {
    await ref
        .read(utilisateursServiceProvider)
        .supprimerUtilisateur(idUtilisateur: idUtilisateur);
    final current = state.value ?? [];
    state = AsyncData(current.where((u) => u.id != idUtilisateur).toList());
  }
}
