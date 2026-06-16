// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(materielsDisponibles)
final materielsDisponiblesProvider = MaterielsDisponiblesFamily._();

final class MaterielsDisponiblesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Materiel>>,
          List<Materiel>,
          FutureOr<List<Materiel>>
        >
    with $FutureModifier<List<Materiel>>, $FutureProvider<List<Materiel>> {
  MaterielsDisponiblesProvider._({
    required MaterielsDisponiblesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'materielsDisponiblesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$materielsDisponiblesHash();

  @override
  String toString() {
    return r'materielsDisponiblesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Materiel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Materiel>> create(Ref ref) {
    final argument = this.argument as String;
    return materielsDisponibles(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MaterielsDisponiblesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$materielsDisponiblesHash() =>
    r'40264b3a9d13066dc2bb6b7907345a8760a8e06c';

final class MaterielsDisponiblesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Materiel>>, String> {
  MaterielsDisponiblesFamily._()
    : super(
        retry: null,
        name: r'materielsDisponiblesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MaterielsDisponiblesProvider call(String idCategorie) =>
      MaterielsDisponiblesProvider._(argument: idCategorie, from: this);

  @override
  String toString() => r'materielsDisponiblesProvider';
}

@ProviderFor(demandeById)
final demandeByIdProvider = DemandeByIdFamily._();

final class DemandeByIdProvider
    extends
        $FunctionalProvider<
          DemandeAffectation?,
          DemandeAffectation?,
          DemandeAffectation?
        >
    with $Provider<DemandeAffectation?> {
  DemandeByIdProvider._({
    required DemandeByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'demandeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$demandeByIdHash();

  @override
  String toString() {
    return r'demandeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DemandeAffectation?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DemandeAffectation? create(Ref ref) {
    final argument = this.argument as String;
    return demandeById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DemandeAffectation? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DemandeAffectation?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DemandeByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$demandeByIdHash() => r'c9e18a5269b914fff78de222184f1f6208aa49ea';

final class DemandeByIdFamily extends $Family
    with $FunctionalFamilyOverride<DemandeAffectation?, String> {
  DemandeByIdFamily._()
    : super(
        retry: null,
        name: r'demandeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DemandeByIdProvider call(String id) =>
      DemandeByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'demandeByIdProvider';
}
