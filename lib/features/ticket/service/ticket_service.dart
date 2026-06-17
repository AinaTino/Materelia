import 'package:materelia/shared/services/supabase_service.dart';

class TicketService {
  final _client = SupabaseService.client;

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
          .select('*, lignes_ticket(*, materiels(*))')
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

  /// Valider la demande (sans générer de code)
  Future<void> validateTicket(String ticketId, String technicienId) async {
    try {
      await _client.from('tickets').update({
        'etat': 'VALIDE',
        'id_valideur': technicienId,
        'date_validation': DateTime.now().toIso8601String(),
      }).eq('id_ticket', ticketId);

      final ticket = await _client
          .from('tickets')
          .select('id_demandeur, code_remise')
          .eq('id_ticket', ticketId)
          .single();

      await _client.from('notifications').insert({
        'id_utilisateur': ticket['id_demandeur'],
        'message':
            'Votre demande a été validée. Présentez-vous avec le code : ${ticket['code_remise']} pour récupérer le matériel.',
        'type': 'TICKET_VALIDATED',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Refuser la demande (remet les matériels en stock)
  Future<void> refuseTicket(String ticketId, String motif, String technicienId) async {
    try {
      final ticket = await _client
          .from('tickets')
          .select('id_demandeur, lignes_ticket(id_materiel)')
          .eq('id_ticket', ticketId)
          .single();

      final userId = ticket['id_demandeur'];
      final lignes = ticket['lignes_ticket'] as List<dynamic>? ?? [];
      final materielIds = lignes.map((l) => (l as Map)['id_materiel'] as String).toList();

      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EN_STOCK'})
            .filter('id_materiel', 'in', materielIds);
      }

      await _client.from('tickets').update({
        'etat': 'REFUSE',
        'motif_refus': motif,
        'id_valideur': technicienId,
        'date_validation': DateTime.now().toIso8601String(),
      }).eq('id_ticket', ticketId);

      await _client.from('notifications').insert({
        'id_utilisateur': userId,
        'message': 'Votre demande de matériel a été refusée. Motif: $motif',
        'type': 'TICKET_REFUSED',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Confirmer la remise physique (technicien saisit le code)
  /// ✅ Ajout de la mise à jour des matériels à EMPRUNTE
  Future<void> confirmerRemise(String ticketId, String code, String technicienId) async {
    try {
      // 1. Vérifier le code et l'expiration, récupérer les lignes
      final ticket = await _client
          .from('tickets')
          .select('code_remise, date_expiration_code, id_demandeur, id_zone, etat, lignes_ticket(id_materiel)')
          .eq('id_ticket', ticketId)
          .maybeSingle();

      if (ticket == null) {
        throw Exception('Ticket introuvable.');
      }

      final currentEtat = ticket['etat']?.toString() ?? '';

      // Vérifier que le ticket n'est pas déjà terminé
      if (currentEtat == 'RENDU' || currentEtat == 'REFUSE' || currentEtat == 'EXPIRE') {
        throw Exception('Ce ticket est déjà terminé (état: $currentEtat).');
      }

      final storedCode = ticket['code_remise']?.toString();
      final expiration = ticket['date_expiration_code'] != null
          ? DateTime.parse(ticket['date_expiration_code'])
          : null;

      if (storedCode == null || storedCode != code) {
        throw Exception('Code de remise invalide.');
      }

      if (expiration != null && DateTime.now().isAfter(expiration)) {
        throw Exception('Le code de remise a expiré (24h).');
      }

      // 2. Récupérer les IDs des matériels
      final lignes = ticket['lignes_ticket'] as List<dynamic>? ?? [];
      final materielIds = lignes.map((l) => (l as Map)['id_materiel'] as String).toList();

      // 3. ✅ Mettre à jour les matériels → EMPRUNTE
      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EMPRUNTE'})
            .filter('id_materiel', 'in', materielIds);
      }

      // 4. Mettre à jour le ticket → EN_COURS
      final result = await _client
          .from('tickets')
          .update({
            'etat': 'EN_COURS',
            'id_remetteur': technicienId,
          })
          .eq('id_ticket', ticketId)
          .select('id_ticket');

      // Vérifier que la mise à jour a bien affecté une ligne
      if (result == null || (result as List).isEmpty) {
        throw Exception(
            'Impossible de mettre à jour le ticket. Vérifiez que vous avez les droits sur ce ticket (zone).');
      }

      // 5. Notifier l'utilisateur
      await _client.from('notifications').insert({
        'id_utilisateur': ticket['id_demandeur'],
        'message': 'Le matériel vous a été remis. Pensez à le retourner à la date prévue.',
        'type': 'TICKET_IN_PROGRESS',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Confirmer le retour physique
  Future<void> confirmReturn(String ticketId, String technicienId) async {
    try {
      final ticketData = await _client
          .from('tickets')
          .select('id_demandeur, lignes_ticket(id_materiel)')
          .eq('id_ticket', ticketId)
          .maybeSingle();

      if (ticketData == null) {
        throw Exception('Ticket introuvable.');
      }

      final userId = ticketData['id_demandeur'];
      final linesRes = ticketData['lignes_ticket'] as List<dynamic>? ?? [];
      final materielIds = linesRes.map((l) => (l as Map)['id_materiel'] as String).toList();

      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EN_STOCK'})
            .filter('id_materiel', 'in', materielIds);
      }

      // Mise à jour du ticket avec vérification
      final result = await _client
          .from('tickets')
          .update({
            'etat': 'RENDU',
            'id_remetteur': technicienId,
          })
          .eq('id_ticket', ticketId)
          .select('id_ticket');

      if (result == null || (result as List).isEmpty) {
        throw Exception('Impossible de confirmer le retour. Vérifiez vos droits.');
      }

      await _client.from('notifications').insert({
        'id_utilisateur': userId,
        'message': 'Retour de matériel confirmé. Merci !',
        'type': 'TICKET_RETURNED',
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Trouver un ticket par son code de remise
  Future<Map<String, dynamic>> trouverTicketParCode(String code) async {
    try {
      final ticket = await _client
          .from('tickets')
          .select('id_ticket, code_remise, date_expiration_code, id_demandeur, id_zone, etat')
          .eq('code_remise', code)
          .maybeSingle();

      if (ticket == null) {
        throw Exception('Code de remise invalide. Vérifiez le code saisi.');
      }

      return Map<String, dynamic>.from(ticket as Map);
    } catch (e) {
      rethrow;
    }
  }

  /// Confirmer la remise physique par code de remise
  Future<void> confirmerRemiseParCode(String code, String technicienId) async {
    try {
      // 1. Trouver le ticket par code
      final ticket = await trouverTicketParCode(code);
      
      final currentEtat = ticket['etat']?.toString() ?? '';
      
      // ✅ Vérifier que le ticket est en attente ou validé
      if (currentEtat == 'RENDU' || currentEtat == 'REFUSE' || currentEtat == 'EXPIRE') {
        throw Exception('Ce ticket est déjà terminé (état: $currentEtat).');
      }
      
      // ✅ Vérifier que le ticket n'est pas déjà en cours
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

      // 2. Récupérer les IDs des matériels
      final lignes = await _client
          .from('lignes_ticket')
          .select('id_materiel')
          .eq('id_ticket', ticketId);

      final materielIds = (lignes as List<dynamic>?)
              ?.map((l) => (l as Map)['id_materiel'] as String)
              .toList() ??
          [];

      // 3. Mettre à jour les matériels → EMPRUNTE
      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EMPRUNTE'})
            .filter('id_materiel', 'in', materielIds);
      }

      // 4. Mettre à jour le ticket → EN_COURS
      await _client
          .from('tickets')
          .update({
            'etat': 'EN_COURS',
            'id_remetteur': technicienId,
          })
          .eq('id_ticket', ticketId);

      // 5. Notifier l'utilisateur
      await _client.from('notifications').insert({
        'id_utilisateur': ticket['id_demandeur'],
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
      // 1. Trouver le ticket par code
      final ticket = await trouverTicketParCode(code);
      
      final currentEtat = ticket['etat']?.toString() ?? '';
      
      // ✅ Vérifier que le ticket est en cours
      if (currentEtat != 'EN_COURS') {
        throw Exception('Le retour n\'est possible que pour les tickets en cours (état: $currentEtat).');
      }

      // ✅ Vérifier que le code n'est pas expiré
      final expiration = ticket['date_expiration_code'] != null
          ? DateTime.parse(ticket['date_expiration_code'])
          : null;

      if (expiration != null && DateTime.now().isAfter(expiration)) {
        throw Exception('Le code de remise a expiré (24h).');
      }

      final ticketId = ticket['id_ticket'];
      final userId = ticket['id_demandeur'];

      // 2. Récupérer les IDs des matériels
      final lignes = await _client
          .from('lignes_ticket')
          .select('id_materiel')
          .eq('id_ticket', ticketId);

      final materielIds = (lignes as List<dynamic>?)
              ?.map((l) => (l as Map)['id_materiel'] as String)
              .toList() ??
          [];

      // 3. Mettre à jour les matériels → EN_STOCK
      if (materielIds.isNotEmpty) {
        await _client
            .from('materiels')
            .update({'etat': 'EN_STOCK'})
            .filter('id_materiel', 'in', materielIds);
      }

      // 4. ✅ Mettre à jour le ticket → RENDU
      //    ET supprimer le code de remise pour qu'il ne soit plus utilisable
      await _client
          .from('tickets')
          .update({
            'etat': 'RENDU',
            'id_remetteur': technicienId,
            'code_remise': null,           // ✅ Supprimer le code
            'date_expiration_code': null,  // ✅ Supprimer la date d'expiration
          })
          .eq('id_ticket', ticketId);

      // 5. Notifier l'utilisateur
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