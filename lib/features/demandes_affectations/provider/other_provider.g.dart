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

@ProviderFor(categorieDemandeById)
final categorieDemandeByIdProvider = CategorieDemandeByIdFamily._();

final class CategorieDemandeByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Categorie>,
          Categorie,
          FutureOr<Categorie>
        >
    with $FutureModifier<Categorie>, $FutureProvider<Categorie> {
  CategorieDemandeByIdProvider._({
    required CategorieDemandeByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categorieDemandeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categorieDemandeByIdHash();

  @override
  String toString() {
    return r'categorieDemandeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Categorie> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Categorie> create(Ref ref) {
    final argument = this.argument as String;
    return categorieDemandeById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategorieDemandeByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categorieDemandeByIdHash() =>
    r'741f802051e5ea5455dd99d0f9c3c50f12915ae4';

final class CategorieDemandeByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Categorie>, String> {
  CategorieDemandeByIdFamily._()
    : super(
        retry: null,
        name: r'categorieDemandeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategorieDemandeByIdProvider call(String idCategorie) =>
      CategorieDemandeByIdProvider._(argument: idCategorie, from: this);

  @override
  String toString() => r'categorieDemandeByIdProvider';
}

@ProviderFor(demandeurById)
final demandeurByIdProvider = DemandeurByIdFamily._();

final class DemandeurByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Utilisateur>,
          Utilisateur,
          FutureOr<Utilisateur>
        >
    with $FutureModifier<Utilisateur>, $FutureProvider<Utilisateur> {
  DemandeurByIdProvider._({
    required DemandeurByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'demandeurByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$demandeurByIdHash();

  @override
  String toString() {
    return r'demandeurByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Utilisateur> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Utilisateur> create(Ref ref) {
    final argument = this.argument as String;
    return demandeurById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DemandeurByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$demandeurByIdHash() => r'6ae5b75a50d0c13b00a6dc87a997efe151b6cb76';

final class DemandeurByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Utilisateur>, String> {
  DemandeurByIdFamily._()
    : super(
        retry: null,
        name: r'demandeurByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DemandeurByIdProvider call(String idDemandeur) =>
      DemandeurByIdProvider._(argument: idDemandeur, from: this);

  @override
  String toString() => r'demandeurByIdProvider';
}

@ProviderFor(valideurById)
final valideurByIdProvider = ValideurByIdFamily._();

final class ValideurByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Utilisateur?>,
          Utilisateur?,
          FutureOr<Utilisateur?>
        >
    with $FutureModifier<Utilisateur?>, $FutureProvider<Utilisateur?> {
  ValideurByIdProvider._({
    required ValideurByIdFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'valideurByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$valideurByIdHash();

  @override
  String toString() {
    return r'valideurByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Utilisateur?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Utilisateur?> create(Ref ref) {
    final argument = this.argument as String?;
    return valideurById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ValideurByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$valideurByIdHash() => r'979e0abec8535e7c67c9f9f3135b323a9f043160';

final class ValideurByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Utilisateur?>, String?> {
  ValideurByIdFamily._()
    : super(
        retry: null,
        name: r'valideurByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ValideurByIdProvider call(String? idValideur) =>
      ValideurByIdProvider._(argument: idValideur, from: this);

  @override
  String toString() => r'valideurByIdProvider';
}
