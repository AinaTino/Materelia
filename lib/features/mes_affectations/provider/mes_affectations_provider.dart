import 'package:materelia/features/mes_affectations/service/mes_affectations_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mes_affectations_provider.g.dart';

@riverpod
MesAffectationsService mesAffectationsService(Ref ref) {
  return MesAffectationsService();
}

@riverpod
Future<AffectationDetail> affectationDetail(Ref ref, String id) async {
  return ref.read(mesAffectationsServiceProvider).fetchAffectation(id);
}

@riverpod
class MesAffectationsController extends _$MesAffectationsController {
  @override
  Future<List<AffectationListItem>> build() async {
    return ref.read(mesAffectationsServiceProvider).listAffectations();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

  // Future<void> revoquerAffectation(String id) async {
  //   await ref.read(mesAffectationsServiceProvider).revoquerAffectation(id);
  //   ref.invalidateSelf();
  //   await future; // attend que le rebuild soit fini
  // }

  // Future<void> renouvelerAffectation(String id) async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     await ref.read(mesAffectationsServiceProvider).renouvelerAffectation(id);
  //     return ref.read(mesAffectationsServiceProvider).listAffectations();
  //   });
  // }
