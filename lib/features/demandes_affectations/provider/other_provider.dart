import 'package:materelia/features/demandes_affectations/provider/demandes_affectations_provider.dart';
import 'package:materelia/shared/models/categorie.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/models/materiel.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'other_provider.g.dart';

@riverpod
Future<List<Materiel>> materielsDisponibles(Ref ref, String idCategorie) {
  return ref
      .read(demandesAffectationsServiceProvider)
      .listeMaterielsDispo(idCategorie: idCategorie);
}

@riverpod
DemandeAffectation? demandeById(Ref ref, String id) {
  final liste = ref.watch(demandesAffectationsControllerProvider).value;
  return liste?.firstWhere((e) => e.id == id);
}

@riverpod
Future<Categorie> categorieDemandeById(Ref ref, String idCategorie) {
  return ref
      .read(demandesAffectationsServiceProvider)
      .getCategorieById(idCategorie);
}

@riverpod
Future<Utilisateur> demandeurById(Ref ref, String idDemandeur) {
  return ref
      .read(demandesAffectationsServiceProvider)
      .getUtilisateurById(idDemandeur);
}

@riverpod
Future<Utilisateur?> valideurById(Ref ref, String? idValideur) async {
  if (idValideur == null) return null;
  return ref
      .read(demandesAffectationsServiceProvider)
      .getUtilisateurById(idValideur);
}
