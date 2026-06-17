import 'package:materelia/shared/services/supabase_service.dart';

class MaterielService {
  final _client = SupabaseService.client;

  /// Récupère la liste des matériels, supporte des filtres simples
  Future<List<Map<String, dynamic>>> fetchMateriels({Map<String, dynamic>? filters}) async {
    try {
      var query = _client.from('materiels').select();

      if (filters != null) {
        if (filters.containsKey('id_categorie')) {
          query = query.eq('id_categorie', filters['id_categorie']);
        }
        if (filters.containsKey('etat')) {
          query = query.eq('etat', filters['etat']);
        }
        if (filters.containsKey('id_stock')) {
          query = query.eq('id_stock', filters['id_stock']);
        }
      }

      final res = await query.order('nom', ascending: true);
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> fetchMaterielDetail(String id) async {
    try {
      final res = await _client.from('materiels').select().eq('id_materiel', id).maybeSingle();
      if (res == null) return null;
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createMateriel(Map<String, dynamic> data) async {
    try {
      final res = await _client.from('materiels').insert(data).select().single();
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMateriel(String id, Map<String, dynamic> data) async {
    try {
      await _client.from('materiels').update(data).eq('id_materiel', id);
    } catch (e) {
      rethrow;
    }
  }

  /// Rather than deleting, mark as REFORME by default
  Future<void> deleteMateriel(String id, {bool hardDelete = false}) async {
    if (hardDelete) {
      try {
        await _client.from('materiels').delete().eq('id_materiel', id);
      } catch (e) {
        rethrow;
      }
    } else {
      try {
        await _client.from('materiels').update({'etat': 'REFORME'}).eq('id_materiel', id);
      } catch (e) {
        rethrow;
      }
    }
  }
}
