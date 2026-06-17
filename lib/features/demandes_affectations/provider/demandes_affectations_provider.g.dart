// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demandes_affectations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(demandesAffectationsService)
final demandesAffectationsServiceProvider =
    DemandesAffectationsServiceProvider._();

final class DemandesAffectationsServiceProvider
    extends
        $FunctionalProvider<
          DemandesAffectationsService,
          DemandesAffectationsService,
          DemandesAffectationsService
        >
    with $Provider<DemandesAffectationsService> {
  DemandesAffectationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demandesAffectationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demandesAffectationsServiceHash();

  @$internal
  @override
  $ProviderElement<DemandesAffectationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DemandesAffectationsService create(Ref ref) {
    return demandesAffectationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DemandesAffectationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DemandesAffectationsService>(value),
    );
  }
}

String _$demandesAffectationsServiceHash() =>
    r'4b96f17966d49f970c6a9d8d03fec40c7f16dad5';

@ProviderFor(DemandesAffectationsController)
final demandesAffectationsControllerProvider =
    DemandesAffectationsControllerProvider._();

final class DemandesAffectationsControllerProvider
    extends
        $AsyncNotifierProvider<
          DemandesAffectationsController,
          List<DemandeAffectation>
        > {
  DemandesAffectationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'demandesAffectationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$demandesAffectationsControllerHash();

  @$internal
  @override
  DemandesAffectationsController create() => DemandesAffectationsController();
}

String _$demandesAffectationsControllerHash() =>
    r'4415cfb2bf4723b6333c3c954408da14c1bbf1a0';

abstract class _$DemandesAffectationsController
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
