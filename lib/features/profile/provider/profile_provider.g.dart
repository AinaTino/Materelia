// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileService)
final profileServiceProvider = ProfileServiceProvider._();

final class ProfileServiceProvider
    extends $FunctionalProvider<ProfileService, ProfileService, ProfileService>
    with $Provider<ProfileService> {
  ProfileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileServiceHash();

  @$internal
  @override
  $ProviderElement<ProfileService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileService create(Ref ref) {
    return profileService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileService>(value),
    );
  }
}

String _$profileServiceHash() => r'7d08a59b36b20e0c5764765d031c34e298235d3e';

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, Utilisateur> {
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'dbf8ab4abbb6a2d35e22aba4a2967ca521819b2c';

abstract class _$ProfileController extends $AsyncNotifier<Utilisateur> {
  FutureOr<Utilisateur> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Utilisateur>, Utilisateur>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Utilisateur>, Utilisateur>,
              AsyncValue<Utilisateur>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(zoneGeree)
final zoneGereeProvider = ZoneGereeProvider._();

final class ZoneGereeProvider
    extends $FunctionalProvider<AsyncValue<Gerer?>, Gerer?, FutureOr<Gerer?>>
    with $FutureModifier<Gerer?>, $FutureProvider<Gerer?> {
  ZoneGereeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zoneGereeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zoneGereeHash();

  @$internal
  @override
  $FutureProviderElement<Gerer?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Gerer?> create(Ref ref) {
    return zoneGeree(ref);
  }
}

String _$zoneGereeHash() => r'95cf0fc4d23958739c0f14f654536ecb97b58cc5';

@ProviderFor(zoneById)
final zoneByIdProvider = ZoneByIdFamily._();

final class ZoneByIdProvider
    extends $FunctionalProvider<AsyncValue<Zone>, Zone, FutureOr<Zone>>
    with $FutureModifier<Zone>, $FutureProvider<Zone> {
  ZoneByIdProvider._({
    required ZoneByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'zoneByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$zoneByIdHash();

  @override
  String toString() {
    return r'zoneByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Zone> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Zone> create(Ref ref) {
    final argument = this.argument as String;
    return zoneById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ZoneByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$zoneByIdHash() => r'2054e4694211ce124d1afd00d5cfdab7c8c1354c';

final class ZoneByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Zone>, String> {
  ZoneByIdFamily._()
    : super(
        retry: null,
        name: r'zoneByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ZoneByIdProvider call(String idZone) =>
      ZoneByIdProvider._(argument: idZone, from: this);

  @override
  String toString() => r'zoneByIdProvider';
}

@ProviderFor(zonesAvecStocks)
final zonesAvecStocksProvider = ZonesAvecStocksProvider._();

final class ZonesAvecStocksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ZoneAvecStocks>>,
          List<ZoneAvecStocks>,
          FutureOr<List<ZoneAvecStocks>>
        >
    with
        $FutureModifier<List<ZoneAvecStocks>>,
        $FutureProvider<List<ZoneAvecStocks>> {
  ZonesAvecStocksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zonesAvecStocksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zonesAvecStocksHash();

  @$internal
  @override
  $FutureProviderElement<List<ZoneAvecStocks>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ZoneAvecStocks>> create(Ref ref) {
    return zonesAvecStocks(ref);
  }
}

String _$zonesAvecStocksHash() => r'5f565d9b4898a7d12be307f2aa99df53945a6f6b';
