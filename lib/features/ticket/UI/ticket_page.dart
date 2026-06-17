import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/filtre_chips.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/ticket_provider.dart';
import '../widgets/ticket_card.dart';
import 'ticket_detail_page.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  String _search = '';
  String? _filtreEtat;

  final Map<String, String> _etats = {
    'EN_ATTENTE': 'En attente',
    'VALIDE': 'Validé',
    'EN_COURS': 'En cours',
    'RENDU': 'Rendu',
    'EXPIRE': 'Expiré',
    'REFUSE': 'Refusé',
  };

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final isLoading = profileAsync.isLoading;

    return Scaffold(
      body: profileAsync.when(
        loading: () => const Center(child: AppLoading()),
        error: (e, _) => Center(
          child: ErrorView(
            message: e.toString(),
            onRetry: () => ref.invalidate(profileControllerProvider),
          ),
        ),
        data: (user) {
          final isTechOrAdmin = user.role == AppConstants.roleTechnicien ||
              user.role == AppConstants.roleAdmin;

          final ticketsAsync = isTechOrAdmin
              ? ref.watch(ticketsTechnicienProvider(user.id))
              : ref.watch(ticketsUserProvider(user.id));

          return Column(
            children: [
              Toolbar(
                showDetail: false,
                onSearch: (v) => setState(() => _search = v),
                onToggleDetail: () {},
                onRefresh: () {
                  if (isTechOrAdmin) {
                    ref.invalidate(ticketsTechnicienProvider(user.id));
                  } else {
                    ref.invalidate(ticketsUserProvider(user.id));
                  }
                },
                creer: null,
              ),
              const Divider(height: 1),

              FiltreChips(
                filtreActif: _filtreEtat,
                etats: _etats,
                onFiltreChange: (etat) => setState(() => _filtreEtat = etat),
              ),
              const Divider(height: 1),

              SizedBox(
                height: 2,
                child: isLoading
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),

              Expanded(
                child: ticketsAsync.when(
                  loading: () => const AppLoading(),
                  error: (e, _) => ErrorView(
                    message: e.toString(),
                    onRetry: () {
                      if (isTechOrAdmin) {
                        ref.invalidate(ticketsTechnicienProvider(user.id));
                      } else {
                        ref.invalidate(ticketsUserProvider(user.id));
                      }
                    },
                  ),
                  data: (ticketsList) {
                    // Filtrer par état
                    var filtered = ticketsList;
                    if (_filtreEtat != null) {
                      filtered = filtered.where((t) => t['etat'] == _filtreEtat).toList();
                    }
                    // Filtrer par recherche (lieu)
                    if (_search.isNotEmpty) {
                      final search = _search.toLowerCase();
                      filtered = filtered.where((t) {
                        final lieu = t['lieu_utilisation']?.toString().toLowerCase() ?? '';
                        return lieu.contains(search);
                      }).toList();
                    }

                    if (filtered.isEmpty) {
                      return Center(
                        child: EmptyState(
                          message: 'Aucun ticket trouvé',
                          subMessage: 'Aucun ticket ne correspond à vos critères.',
                          icon: Icons.confirmation_number_outlined,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final t = filtered[index];
                        final id = t['id_ticket']?.toString() ?? '';
                        final etat = t['etat']?.toString() ?? '';
                        final lieu = t['lieu_utilisation']?.toString() ?? 'Non spécifié';
                        final dateRaw = t['date_creation']?.toString();
                        final dateCreation = dateRaw != null ? DateTime.parse(dateRaw) : null;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TicketCard(
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
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}