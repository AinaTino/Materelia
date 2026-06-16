// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mes_affectations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mesAffectationsService)
final mesAffectationsServiceProvider = MesAffectationsServiceProvider._();

final class MesAffectationsServiceProvider
    extends
        $FunctionalProvider<
          MesAffectationsService,
          MesAffectationsService,
          MesAffectationsService
        >
    with $Provider<MesAffectationsService> {
  MesAffectationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesAffectationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesAffectationsServiceHash();

  @$internal
  @override
  $ProviderElement<MesAffectationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MesAffectationsService create(Ref ref) {
    return mesAffectationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MesAffectationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MesAffectationsService>(value),
    );
  }
}

String _$mesAffectationsServiceHash() =>
    r'0e7a0271ca94b07495042f36603d91ccb712827f';

@ProviderFor(affectationDetail)
final affectationDetailProvider = AffectationDetailFamily._();

final class AffectationDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<AffectationDetail>,
          AffectationDetail,
          FutureOr<AffectationDetail>
        >
    with
        $FutureModifier<AffectationDetail>,
        $FutureProvider<AffectationDetail> {
  AffectationDetailProvider._({
    required AffectationDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'affectationDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$affectationDetailHash();

  @override
  String toString() {
    return r'affectationDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AffectationDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AffectationDetail> create(Ref ref) {
    final argument = this.argument as String;
    return affectationDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AffectationDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$affectationDetailHash() => r'6410f02616dee66a3816f648aef4db9a3c6d90b5';

final class AffectationDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AffectationDetail>, String> {
  AffectationDetailFamily._()
    : super(
        retry: null,
        name: r'affectationDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AffectationDetailProvider call(String id) =>
      AffectationDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'affectationDetailProvider';
}

@ProviderFor(MesAffectationsController)
final mesAffectationsControllerProvider = MesAffectationsControllerProvider._();

final class MesAffectationsControllerProvider
    extends
        $AsyncNotifierProvider<
          MesAffectationsController,
          List<AffectationListItem>
        > {
  MesAffectationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mesAffectationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mesAffectationsControllerHash();

  @$internal
  @override
  MesAffectationsController create() => MesAffectationsController();
}

String _$mesAffectationsControllerHash() =>
    r'33d4598e868e12763d25663d10fde1ac41c49e22';

abstract class _$MesAffectationsController
    extends $AsyncNotifier<List<AffectationListItem>> {
  FutureOr<List<AffectationListItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AffectationListItem>>,
              List<AffectationListItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AffectationListItem>>,
                List<AffectationListItem>
              >,
              AsyncValue<List<AffectationListItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
