import 'package:materelia/shared/services/supabase_service.dart';

class PanierService {
  final _client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> fetchCategoriesDisponibles() async {
    try {
      final res = await _client
          .from('categories')
          .select('*, materiels( id_materiel, nom, reference, description, etat )')
          .filter('materiels.etat', 'eq', 'EN_STOCK');

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) {
        final cat = Map<String, dynamic>.from(e as Map);
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

  Future<dynamic> validatePanier(List<Map<String, dynamic>> lignesCategorie, String userId, String lieu, DateTime dateFin) async {
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