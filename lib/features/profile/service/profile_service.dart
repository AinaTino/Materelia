import 'package:materelia/shared/models/gerer.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/models/zone.dart';
import 'package:materelia/shared/models/stock.dart';
import 'package:materelia/shared/services/supabase_service.dart';

/// Regroupe une zone et ses stocks associés.
class ZoneAvecStocks {
  final Zone zone;
  final List<Stock> stocks;

  const ZoneAvecStocks({required this.zone, required this.stocks});
}

class ProfileService {
  final _db = SupabaseService.client;

  Future<Utilisateur> getCurrentUserProfile() async {
    final userId = _db.auth.currentUser!.id;
    final response = await _db
        .from("utilisateurs")
        .select()
        .eq('id_utilisateur', userId)
        .single();
    return Utilisateur.fromJson(response);
  }

  Future<Utilisateur> updateProfil({
    required String nom,
    required String prenom,
  }) async {
    final userId = _db.auth.currentUser!.id;
    final data = await _db
        .from('utilisateurs')
        .update({'nom': nom, 'prenom': prenom})
        .eq('id_utilisateur', userId)
        .select()
        .single();
    return Utilisateur.fromJson(data);
  }

  // ─── Ancienne méthode conservée pour compatibilité ───────────────────────

  /// Retourne la première entrée dans `gerer` pour l'utilisateur connecté.
  /// @deprecated Préférer [getZonesAvecStocks] pour un affichage complet.
  Future<Gerer?> getZoneGeree() async {
    final userId = _db.auth.currentUser!.id;
    final data = await _db
        .from('gerer')
        .select()
        .eq('id_utilisateur', userId)
        .maybeSingle();
    if (data == null) return null;
    return Gerer.fromJson(data);
  }

  Future<Zone> getZoneById(String idZone) async {
    final data = await _db
        .from('zones')
        .select()
        .eq('id_zone', idZone)
        .single();
    return Zone.fromJson(data);
  }

  // ─── Nouvelles méthodes multi-zones ──────────────────────────────────────

  /// Retourne toutes les zones gérées par le technicien connecté,
  /// chacune enrichie de la liste de ses stocks.
  Future<List<ZoneAvecStocks>> getZonesAvecStocks() async {
    final userId = _db.auth.currentUser!.id;

    // 1. Récupérer toutes les entrées gerer de cet utilisateur
    final gererRows = await _db
        .from('gerer')
        .select('id_zone')
        .eq('id_utilisateur', userId);

    if (gererRows.isEmpty) return [];

    final zoneIds = (gererRows as List)
        .map((r) => r['id_zone'] as String)
        .toList();

    // 2. Récupérer les zones
    final zonesData = await _db
        .from('zones')
        .select()
        .inFilter('id_zone', zoneIds);

    // 3. Récupérer tous les stocks de ces zones en une seule requête
    final stocksData = await _db
        .from('stocks')
        .select()
        .inFilter('id_zone', zoneIds);

    // 4. Grouper les stocks par zone
    final stocksByZone = <String, List<Stock>>{};
    for (final row in stocksData as List) {
      final stock = Stock.fromJson(row);
      stocksByZone.putIfAbsent(stock.idZone, () => []).add(stock);
    }

    // 5. Assembler le résultat
    return (zonesData as List).map((row) {
      final zone = Zone.fromJson(row);
      return ZoneAvecStocks(
        zone: zone,
        stocks: stocksByZone[zone.id] ?? [],
      );
    }).toList();
  }
}