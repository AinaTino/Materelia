// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affectations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(affectationsService)
final affectationsServiceProvider = AffectationsServiceProvider._();

final class AffectationsServiceProvider
    extends
        $FunctionalProvider<
          AffectationsService,
          AffectationsService,
          AffectationsService
        >
    with $Provider<AffectationsService> {
  AffectationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'affectationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$affectationsServiceHash();

  @$internal
  @override
  $ProviderElement<AffectationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AffectationsService create(Ref ref) {
    return affectationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AffectationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AffectationsService>(value),
    );
  }
}

String _$affectationsServiceHash() =>
    r'7fd199a893e52a2243ee69def4e90cf7ded9993b';

@ProviderFor(affectationDetailAdmin)
final affectationDetailAdminProvider = AffectationDetailAdminFamily._();

final class AffectationDetailAdminProvider
    extends
        $FunctionalProvider<
          AsyncValue<AffectationDetail>,
          AffectationDetail,
          FutureOr<AffectationDetail>
        >
    with
        $FutureModifier<AffectationDetail>,
        $FutureProvider<AffectationDetail> {
  AffectationDetailAdminProvider._({
    required AffectationDetailAdminFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'affectationDetailAdminProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$affectationDetailAdminHash();

  @override
  String toString() {
    return r'affectationDetailAdminProvider'
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
    return affectationDetailAdmin(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AffectationDetailAdminProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$affectationDetailAdminHash() =>
    r'd6ca70d4720a70b0a9d58d44c2254f6a78ac4ef3';

final class AffectationDetailAdminFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AffectationDetail>, String> {
  AffectationDetailAdminFamily._()
    : super(
        retry: null,
        name: r'affectationDetailAdminProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AffectationDetailAdminProvider call(String id) =>
      AffectationDetailAdminProvider._(argument: id, from: this);

  @override
  String toString() => r'affectationDetailAdminProvider';
}

@ProviderFor(AffectationsController)
final affectationsControllerProvider = AffectationsControllerProvider._();

final class AffectationsControllerProvider
    extends
        $AsyncNotifierProvider<
          AffectationsController,
          List<AffectationListItem>
        > {
  AffectationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'affectationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$affectationsControllerHash();

  @$internal
  @override
  AffectationsController create() => AffectationsController();
}

String _$affectationsControllerHash() =>
    r'244c6b11bcf75b6f2aa13bfad7c1480e4b246f6c';

abstract class _$AffectationsController
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
