// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardService)
final dashboardServiceProvider = DashboardServiceProvider._();

final class DashboardServiceProvider
    extends
        $FunctionalProvider<
          DashboardService,
          DashboardService,
          DashboardService
        >
    with $Provider<DashboardService> {
  DashboardServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardServiceHash();

  @$internal
  @override
  $ProviderElement<DashboardService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DashboardService create(Ref ref) {
    return dashboardService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardService>(value),
    );
  }
}

String _$dashboardServiceHash() => r'e273c4e29c6a07d5714164e51c8bc01f82c6d5cf';

@ProviderFor(DashboardController)
final dashboardControllerProvider = DashboardControllerProvider._();

final class DashboardControllerProvider
    extends $AsyncNotifierProvider<DashboardController, DashboardStats> {
  DashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardControllerHash();

  @$internal
  @override
  DashboardController create() => DashboardController();
}

String _$dashboardControllerHash() =>
    r'5b33c779d5d5e73f836ef34f608ce1ac64438f8f';

abstract class _$DashboardController extends $AsyncNotifier<DashboardStats> {
  FutureOr<DashboardStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DashboardStats>, DashboardStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardStats>, DashboardStats>,
              AsyncValue<DashboardStats>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
