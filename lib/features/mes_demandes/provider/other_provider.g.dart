// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoriesDisponibles)
final categoriesDisponiblesProvider = CategoriesDisponiblesProvider._();

final class CategoriesDisponiblesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Categorie>>,
          List<Categorie>,
          FutureOr<List<Categorie>>
        >
    with $FutureModifier<List<Categorie>>, $FutureProvider<List<Categorie>> {
  CategoriesDisponiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesDisponiblesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesDisponiblesHash();

  @$internal
  @override
  $FutureProviderElement<List<Categorie>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Categorie>> create(Ref ref) {
    return categoriesDisponibles(ref);
  }
}

String _$categoriesDisponiblesHash() =>
    r'6c0622c83c560812108715efdd7ea3608a0d56b5';

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

String _$demandeByIdHash() => r'6b4cc9288e4f50debb41a2983471d36e8ed7bc92';

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
