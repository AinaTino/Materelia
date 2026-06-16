// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilisateurs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(utilisateursService)
final utilisateursServiceProvider = UtilisateursServiceProvider._();

final class UtilisateursServiceProvider
    extends
        $FunctionalProvider<
          UtilisateursService,
          UtilisateursService,
          UtilisateursService
        >
    with $Provider<UtilisateursService> {
  UtilisateursServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'utilisateursServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$utilisateursServiceHash();

  @$internal
  @override
  $ProviderElement<UtilisateursService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UtilisateursService create(Ref ref) {
    return utilisateursService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UtilisateursService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UtilisateursService>(value),
    );
  }
}

String _$utilisateursServiceHash() =>
    r'09ff9047f58b5c4374ea608791b6d36b592cb880';

@ProviderFor(UtilisateursController)
final utilisateursControllerProvider = UtilisateursControllerProvider._();

final class UtilisateursControllerProvider
    extends $AsyncNotifierProvider<UtilisateursController, List<Utilisateur>> {
  UtilisateursControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'utilisateursControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$utilisateursControllerHash();

  @$internal
  @override
  UtilisateursController create() => UtilisateursController();
}

String _$utilisateursControllerHash() =>
    r'332b2cc54b5cea33d8c2b8f8b2618892e3dac367';

abstract class _$UtilisateursController
    extends $AsyncNotifier<List<Utilisateur>> {
  FutureOr<List<Utilisateur>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Utilisateur>>, List<Utilisateur>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Utilisateur>>, List<Utilisateur>>,
              AsyncValue<List<Utilisateur>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
