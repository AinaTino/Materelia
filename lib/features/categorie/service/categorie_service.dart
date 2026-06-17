import 'package:materelia/shared/services/supabase_service.dart';

class CategorieService {
  final _client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final res = await _client.from('categories').select().order('nom', ascending: true);
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCategorie(Map<String, dynamic> data) async {
    try {
      final res = await _client.from('categories').insert(data).select().single();
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCategorie(String id, Map<String, dynamic> data) async {
    try {
      await _client.from('categories').update(data).eq('id_categorie', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategorie(String id) async {
    try {
      await _client.from('categories').delete().eq('id_categorie', id);
    } catch (e) {
      rethrow;
    }
  }
}
