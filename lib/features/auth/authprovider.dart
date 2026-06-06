import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'authservice.dart';

part 'authprovider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authServiceProvider).signIn(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authServiceProvider).signUp(
        email: email,
        password: password,
        nom: nom,
        prenom: prenom,
      );
    });
  }

  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
  }
}