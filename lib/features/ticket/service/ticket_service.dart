import 'package:materelia/shared/services/supabase_service.dart';

class TicketService {
  final _client = SupabaseService.client;

  // ===================== FETCH =====================

  Future<List<Map<String, dynamic>>> fetchTicketsForUser(String userId) async {
    try {
      final res = await _client
          .from('tickets')
          .select()
          .eq('id_demandeur', userId)
          .order('date_creation', ascending: false);

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchTicketsForZone(String zoneId) async {
    try {
      final res = await _client
          .from('tickets')
          .select()
          .eq('id_zone', zoneId)
          .order('date_creation', ascending: false);

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTicketDetail(String ticketId) async {
    try {
      final res = await _client
          .from('tickets')
          .select('*, lignes_ticket(*)')
          .eq('id_ticket', ticketId)
          .single();
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> fetchZonesForTechnicien(String technicienId) async {
    try {
      final res = await _client
          .from('gerer')
          .select('id_zone')
          .eq('id_utilisateur', technicienId);

      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => (e as Map)['id_zone'] as String).toList();
    } catch (e) {
      rethrow;
    }
  }

  // ===================== CATEGORIES DU TICKET =====================

  /// Récupérer les catégories demandées pour un ticket
  Future<List<Map<String, dynamic>>> getCategoriesDemandees(String ticketId) async {
    try {
      // ✅ Vérifier que ticketId n'est pas vide
      if (ticketId.isEmpty) {
        return [];
      }

      final res = await _client
          .from('lignes_ticket')
          .select('*, categories!categorie_id(id_categorie, nom)')  // ✅ Jointure explicite
          .eq('id_ticket', ticketId)
          .eq('est_categorie', true)
          .not('categorie_id', 'is', null);  // ✅ Ignorer les lignes sans catégorie
      
      final data = (res as List<dynamic>?) ?? [];
      
      // ✅ Filtrer les lignes qui ont une catégorie valide
      return data
          .map((e) => Map<String, dynamic>.from(e as Map))
          .where((e) => e['categorie_id'] != null)
          .toList();
    } catch (e) {
      print('Erreur getCategoriesDemandees: $e');
      rethrow;
    }
  }

  /// Récupérer les matériels remis pour un ticket
  Future<List<Map<String, dynamic>>> getMaterielsRemis(String ticketId) async {
    try {
      final res = await _client
          .from('lignes_ticket')
          .select('*, materiels(*)')
          .eq('id_ticket', ticketId)
          .eq('est_categorie', false)
          .not('id_materiel', 'is', null);
      
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // ===================== MATERIELS DISPONIBLES =====================

  /// Récupérer les matériels disponibles pour une catégorie
  Future<List<Map<String, dynamic>>> getMaterielsDisponiblesPourCategorie(String categorieId) async {
    try {
      final res = await _client
          .from('materiels')
          .select('id_materiel, nom, reference, etat')
          .eq('id_categorie', categorieId)
          .eq('etat', 'EN_STOCK')
          .order('nom', ascending: true);
      
      final data = (res as List<dynamic>?) ?? [];
      return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // ===================== CODE DE REMISE =====================

  /// Trouver un ticket par son code de remise
  Future<Map<String, dynamic>?> trouverTicketParCode(String code) async {
    try {
      final ticket = await _client
          .from('tickets')
          .select('id_ticket, code_remise, date_expiration_code, id_demandeur, id_zone, etat')
          .eq('code_remise', code)
          .maybeSingle();

      if (ticket == null) return null;
      return Map<String, dynamic>.from(ticket as Map);
    } catch (e) {
      rethrow;
    }
  }

  // ===================== ACTIONS =====================

  /// Confirmer la remise physique avec sélection des matériels
  Future<void> confirmerRemiseAvecMateriels({
    required String code,
    required String technicienId,
    required List<String> materielIds,
  }) async {
    try {
      final ticket = await trouverTicketParCode(code);
      
      if (ticket == null) {
        throw Exception('Ticket introuvable.');
      }
      
      final currentEtat = ticket['etat']?.toString() ?? '';
      if (currentEtat == 'RENDU' || currentEtat == 'REFUSE' || currentEtat == 'EXPIRE') {
        throw Exception('Ce ticket est déjà terminé (état: $currentEtat).');
      }
      if (currentEtat == 'EN_COURS') {
        throw Exception('Ce ticket est déjà en cours. Le matériel a déjà été remis.');
      }

      final expiration = ticket['date_expiration_code'] != null
          ? DateTime.parse(ticket['date_expiration_code'])
          : null;
      if (expiration != null && DateTime.now().isAfter(expiration)) {
        throw Exception('Le code de remise a expiré (24h).');
      }

      final ticketId = ticket['id_ticket'];
      final userId = ticket['id_demandeur'];

      // ✅ Récupérer les catégories demandées avec leurs quantités
      final categoriesDemandees = await getCategoriesDemandees(ticketId);
      
      // ✅ Calculer le nombre total de matériels demandés
      int totalDemande = 0;
      for (final cat in categoriesDemandees) {
        totalDemande += (cat['quantite'] as int?) ?? 1;
      }

      // ✅ Vérifier que le nombre de matériels sélectionnés correspond à la demande
      if (materielIds.length != totalDemande) {
        throw Exception(
          'Nombre de matériels sélectionnés (${materielIds.length}) ne correspond pas à la demande ($totalDemande).'
        );
      }

      // Vérifier que les matériels sont disponibles
      for (final materielId in materielIds) {
        final mat = await _client
            .from('materiels')
            .select('etat')
            .eq('id_materiel', materielId)
            .single();
        
        if (mat['etat'] != 'EN_STOCK') {
          throw Exception('Le matériel n\'est pas disponible.');
        }
      }

      // Mettre à jour les matériels → EMPRUNTE
      await _client
          .from('materiels')
          .update({'etat': 'EMPRUNTE'})
          .filter('id_materiel', 'in', materielIds);

      // Supprimer les anciennes lignes de catégories
      await _client
          .from('lignes_ticket')
          .delete()
          .eq('id_ticket', ticketId)
          .eq('est_categorie', true);

      // Créer les nouvelles lignes pour les matériels remis
      await _client.from('lignes_ticket').insert(
        materielIds.map((mid) => ({
          'id_ticket': ticketId,
          'id_materiel': mid,
          'est_categorie': false,
        })).toList(),
      );

      // Mettre à jour le ticket → EN_COURS
      final result = await _client
          .from('tickets')
          .update({
            'etat': 'EN_COURS',
            'id_remetteur': technicienId,
          })
          .eq('id_ticket', ticketId)
          .select('id_ticket');

      if (result == null || (result as List).isEmpty) {
        throw Exception('Impossible de mettre à jour le ticket.');
      }

      // Notifier l'utilisateur
      await _client.from('notifications').insert({
        'id_utilisateur': userId,
        'message': 'Le matériel vous a été remis. Pensez à le retourner à la date prévue.',
        'type': 'TICKET_IN_PROGRESS',
      });

    } catch (e) {
      rethrow;
    }
  }

  /// Confirmer le retour physique par code de remise
  Future<void> confirmerRetourParCode(String code, String technicienId) async {
    try {
      final ticket = await trouverTicketParCode(code);
      
      if (ticket == null) {
        throw Exception('Ticket introuvable.');
      }
      
      final currentEtat = ticket['etat']?.toString() ?? '';
      if (currentEtat != 'EN_COURS') {
        throw Exception('Le retour n\'est possible que pour les tickets en cours (état: $currentEtat).');
      }

      final expiration = ticket['date_expiration_code'] != null
          ? DateTime.parse(ticket['date_expiration_code'])
          : null;
      if (expiration != null && DateTime.now().isAfter(expiration)) {
        throw Exception('Le code de remise a expiré (24h).');
      }

      final ticketId = ticket['id_ticket'];
      final userId = ticket['id_demandeur'];

      // Récupérer les IDs des matériels
      final lignes = await _client
          .from('lignes_ticket')
          .select('id_materiel')
          .eq('id_ticket', ticketId)
          .eq('est_categorie', false)
          .not('id_materiel', 'is', null);

      final materielIds = (lignes as List<dynamic>?)
          ?.map((l) => l['id_materiel'] as String)
          .where((id) => id.isNotEmpty)
          .toList() ?? [];

      // Mettre à jour les matériels → EN_STOCK
      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EN_STOCK'})
            .filter('id_materiel', 'in', materielIds);
      }

      // Mettre à jour le ticket → RENDU et supprimer le code
      await _client
          .from('tickets')
          .update({
            'etat': 'RENDU',
            'id_remetteur': technicienId,
            'code_remise': null,
            'date_expiration_code': null,
          })
          .eq('id_ticket', ticketId);

      // Notifier l'utilisateur
      await _client.from('notifications').insert({
        'id_utilisateur': userId,
        'message': 'Retour de matériel confirmé. Merci !',
        'type': 'TICKET_RETURNED',
      });

    } catch (e) {
      rethrow;
    }
  }
}