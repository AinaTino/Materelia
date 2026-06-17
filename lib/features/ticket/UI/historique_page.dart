import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import '../provider/ticket_provider.dart';
import '../widgets/ticket_card.dart';
import 'ticket_detail_page.dart';

class HistoriquePage extends ConsumerWidget {
  const HistoriquePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des tickets'),
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (user) {
          final isTechOrAdmin = user.role == AppConstants.roleTechnicien || user.role == AppConstants.roleAdmin;
          if (!isTechOrAdmin) {
            return const Center(child: Text('Accès réservé aux techniciens'));
          }

          final ticketsAsync = ref.watch(ticketsTechnicienProvider(user.id));

          return ticketsAsync.when(
            data: (ticketsList) {
              final historiques = ticketsList.where((t) {
                final etat = t['etat']?.toString() ?? '';
                return etat == 'RENDU' || etat == 'REFUSE' || etat == 'EXPIRE';
              }).toList();

              if (historiques.isEmpty) {
                return const EmptyState(message: 'Aucun ticket historique disponible');
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: historiques.length,
                itemBuilder: (context, index) {
                  final t = historiques[index];
                  final id = t['id_ticket']?.toString() ?? '';
                  final etat = t['etat']?.toString() ?? '';
                  final lieu = t['lieu_utilisation']?.toString() ?? 'Non spécifié';
                  final dateRaw = t['date_creation']?.toString();
                  final dateCreation = dateRaw != null ? DateTime.parse(dateRaw) : null;

                  return TicketCard(
                    id: id,
                    etat: etat,
                    lieu: lieu,
                    dateCreation: dateCreation,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TicketDetailPage(ticketId: id),
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erreur : $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur profile : $e')),
      ),
    );
  }
}
