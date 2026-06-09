import 'package:materelia/features/profile/service/profile_service.dart';
import 'package:materelia/shared/models/utilisateur.dart';
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

    state = await AsyncValue.guard(() async {
      return ref.read(profileServiceProvider).getCurrentUserProfile();
    });
  }

  /*Future<void> updateProfile({
    required String nom,
    required String prenom,
  }) async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(profileServiceProvider).updateProfile(
        nom: nom,
        prenom: prenom,
      );
    });
  }

  Future<void> deleteProfile() async {
    await ref.read(profileServiceProvider).deleteProfile();

    // éventuellement :
    state = const AsyncData(null); // si Utilisateur?
    // ou invalider le provider / rediriger vers Login
  }*/
}