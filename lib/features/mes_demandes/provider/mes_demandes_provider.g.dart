// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mes_demandes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mesDemandesService)
final mesDemandesServiceProvider = MesDemandesServiceProvider._();

final class MesDemandesServiceProvider
    extends
        $FunctionalProvider<
          MesDemandesService,
          MesDemandesService,
          MesDemandesService
        >
    with $Provider<MesDemandesService> {
  MesDemandesServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesDemandesServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesDemandesServiceHash();

  @$internal
  @override
  $ProviderElement<MesDemandesService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MesDemandesService create(Ref ref) {
    return mesDemandesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MesDemandesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MesDemandesService>(value),
    );
  }
}

String _$mesDemandesServiceHash() =>
    r'85f9b74d4f378870e5e11aca7da46422284199bf';

@ProviderFor(MesDemandesController)
final mesDemandesControllerProvider = MesDemandesControllerProvider._();

final class MesDemandesControllerProvider
    extends
        $AsyncNotifierProvider<
          MesDemandesController,
          List<DemandeAffectation>
        > {
  MesDemandesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesDemandesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesDemandesControllerHash();

  @$internal
  @override
  MesDemandesController create() => MesDemandesController();
}

String _$mesDemandesControllerHash() =>
    r'33f6607cf4c00a9d21fd8ef0dbb2a42da291510e';

abstract class _$MesDemandesController
    extends $AsyncNotifier<List<DemandeAffectation>> {
  FutureOr<List<DemandeAffectation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DemandeAffectation>>,
              List<DemandeAffectation>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DemandeAffectation>>,
                List<DemandeAffectation>
              >,
              AsyncValue<List<DemandeAffectation>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
