import 'package:materelia/features/affectations/service/affectations_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'affectations_provider.g.dart';

@riverpod
AffectationsService affectationsService(Ref ref) => AffectationsService();

@riverpod
Future<AffectationDetail> affectationDetailAdmin(Ref ref, String id) async {
  return ref.read(affectationsServiceProvider).fetchAffectation(id);
}

@riverpod
class AffectationsController extends _$AffectationsController {
  @override
  Future<List<AffectationListItem>> build() async {
    return ref.read(affectationsServiceProvider).listAffectations();
  }

  Future<void> refresh() async => ref.invalidateSelf();

  Future<void> revoquer(String id) async {
    await ref.read(affectationsServiceProvider).revoquerAffectation(id);
    ref.invalidateSelf();
  }

  Future<void> renouveler(String id, DateTime dateFinActuelle) async {
    await ref
        .read(affectationsServiceProvider)
        .renouvelerAffectation(id, dateFinActuelle);
    ref.invalidateSelf();
  }
}
