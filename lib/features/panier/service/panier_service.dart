import 'package:materelia/shared/services/supabase_service.dart';

class PanierService {
  final _client = SupabaseService.client;

  /// Récupère les catégories avec au moins un matériel disponible (EN_STOCK)
  Future<List<Map<String, dynamic>>> fetchCategoriesDisponibles() async {
    try {
      final res = await _client
          .from('categories')
          .select('*, materiels( id_materiel, nom, reference, description, etat )')
          .filter('materiels.etat', 'eq', 'EN_STOCK');

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) {
        final cat = Map<String, dynamic>.from(e as Map);
        // Convertir les matériels Supabase en Maps
        if (cat['materiels'] is List) {
          cat['materiels'] = (cat['materiels'] as List<dynamic>)
              .map((m) => Map<String, dynamic>.from(m as Map))
              .toList();
        }
        return cat;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Récupère les matériels pour une catégorie (optionnellement seulement disponibles)
  /// Cette méthode est conservée pour d'éventuels usages, mais non utilisée dans le flux principal.
  Future<List<Map<String, dynamic>>> fetchMaterielsForCategory(String categoryId, {bool onlyAvailable = true}) async {
    var query = _client.from('materiels').select().eq('id_categorie', categoryId);
    if (onlyAvailable) query = query.eq('etat', 'EN_STOCK');

    final res = await query.order('nom', ascending: true);
    try {
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Valide le panier en appelant l'Edge Function `assigner-materiels`.
  /// Reçoit une liste de {categorie_id, nombre} (payload pour l'Edge Function)
  Future<dynamic> validatePanier(List<Map<String, dynamic>> lignesCategorie, String userId, String lieu, DateTime dateFin) async {
    // Construire le payload pour l'Edge Function
    final body = {
      'lignes': lignesCategorie,
      'userId': userId,
      'lieu_utilisation': lieu,
      'date_fin_prevue': dateFin.toIso8601String(),
    };

    try {
      final res = await SupabaseService.callFunction('assigner-materiels', body: body);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}