// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(utilisateurById)
final utilisateurByIdProvider = UtilisateurByIdFamily._();

final class UtilisateurByIdProvider
    extends $FunctionalProvider<Utilisateur?, Utilisateur?, Utilisateur?>
    with $Provider<Utilisateur?> {
  UtilisateurByIdProvider._({
    required UtilisateurByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'utilisateurByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$utilisateurByIdHash();

  @override
  String toString() {
    return r'utilisateurByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Utilisateur?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Utilisateur? create(Ref ref) {
    final argument = this.argument as String;
    return utilisateurById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Utilisateur? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Utilisateur?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UtilisateurByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$utilisateurByIdHash() => r'34c588a1f19755dc2d4bec886a59faee098ee510';

final class UtilisateurByIdFamily extends $Family
    with $FunctionalFamilyOverride<Utilisateur?, String> {
  UtilisateurByIdFamily._()
    : super(
        retry: null,
        name: r'utilisateurByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UtilisateurByIdProvider call(String id) =>
      UtilisateurByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'utilisateurByIdProvider';
}

@ProviderFor(zonesDisponibles)
final zonesDisponiblesProvider = ZonesDisponiblesProvider._();

final class ZonesDisponiblesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Zone>>,
          List<Zone>,
          FutureOr<List<Zone>>
        >
    with $FutureModifier<List<Zone>>, $FutureProvider<List<Zone>> {
  ZonesDisponiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zonesDisponiblesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zonesDisponiblesHash();

  @$internal
  @override
  $FutureProviderElement<List<Zone>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Zone>> create(Ref ref) {
    return zonesDisponibles(ref);
  }
}

String _$zonesDisponiblesHash() => r'71eb1c116282198295b52c25b06ef0b8e6b5c37e';

@ProviderFor(zoneTechnicien)
final zoneTechnicienProvider = ZoneTechnicienFamily._();

final class ZoneTechnicienProvider
    extends $FunctionalProvider<AsyncValue<Gerer?>, Gerer?, FutureOr<Gerer?>>
    with $FutureModifier<Gerer?>, $FutureProvider<Gerer?> {
  ZoneTechnicienProvider._({
    required ZoneTechnicienFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'zoneTechnicienProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$zoneTechnicienHash();

  @override
  String toString() {
    return r'zoneTechnicienProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Gerer?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Gerer?> create(Ref ref) {
    final argument = this.argument as String;
    return zoneTechnicien(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ZoneTechnicienProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$zoneTechnicienHash() => r'94aa7c1e8949901b7a702c9c26bd147cf54afcc5';

final class ZoneTechnicienFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Gerer?>, String> {
  ZoneTechnicienFamily._()
    : super(
        retry: null,
        name: r'zoneTechnicienProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ZoneTechnicienProvider call(String idUtilisateur) =>
      ZoneTechnicienProvider._(argument: idUtilisateur, from: this);

  @override
  String toString() => r'zoneTechnicienProvider';
}
