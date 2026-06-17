import 'package:materelia/shared/services/supabase_service.dart';

class ZoneService {
  final _client = SupabaseService.client;

  Future<List<Map<String, dynamic>>> fetchZones() async {
    try {
      final res = await _client.from('zones').select().order('nom', ascending: true);
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createZone(Map<String, dynamic> data) async {
    try {
      final res = await _client.from('zones').insert(data).select().single();
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZone(String id, Map<String, dynamic> data) async {
    try {
      await _client.from('zones').update(data).eq('id_zone', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteZone(String id) async {
    try {
      await _client.from('zones').delete().eq('id_zone', id);
    } catch (e) {
      rethrow;
    }
  }
}
