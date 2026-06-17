import 'package:materelia/shared/services/supabase_service.dart';

class StockService {
  final _client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> fetchStocks() async {
    try {
      final res = await _client.from('stocks').select('*, zones(id_zone, nom)').order('nom', ascending: true);
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createStock(Map<String, dynamic> data) async {
    try {
      final res = await _client.from('stocks').insert(data).select().single();
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateStock(String id, Map<String, dynamic> data) async {
    try {
      await _client.from('stocks').update(data).eq('id_stock', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteStock(String id) async {
    try {
      await _client.from('stocks').delete().eq('id_stock', id);
    } catch (e) {
      rethrow;
    }
  }
}
