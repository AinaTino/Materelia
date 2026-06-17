import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import '../provider/ticket_provider.dart';
import '../widgets/ticket_card.dart';
import 'ticket_detail_page.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  String _selectedFilter = 'TOUS';

  final List<String> _states = [
    'TOUS',
    'EN_ATTENTE',
    'VALIDE',
    'EN_COURS',
    'RENDU',
    'EXPIRE',
    'REFUSE',
  ];

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Tickets'),
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (user) {
          final isTechOrAdmin = user.role == AppConstants.roleTechnicien ||
              user.role == AppConstants.roleAdmin;

          final ticketsAsync = isTechOrAdmin
              ? ref.watch(ticketsTechnicienProvider(user.id))
              : ref.watch(ticketsUserProvider(user.id));

          return Column(
            children: [
              // Filtres
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: _states.map((state) {
                    final isSelected = _selectedFilter == state;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(
                          state == 'TOUS' ? 'Tous' : state,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surfaceContainer,
                        checkmarkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? AppColors.primary : Colors.grey.shade300,
                          ),
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedFilter = state;
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: ticketsAsync.when(
                  data: (ticketsList) {
                    final filtered = ticketsList.where((t) {
                      if (_selectedFilter == 'TOUS') return true;
                      return t['etat'] == _selectedFilter;
                    }).toList();

                    if (filtered.isEmpty) {
                      return const EmptyState(
                        message: 'Aucun ticket trouvé',
                        subMessage: 'Aucun ticket ne correspond à ce filtre.',
                        icon: Icons.confirmation_number_outlined,
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
                  loading: () => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Chargement des tickets...'),
                      ],
                    ),
                  ),
                  error: (e, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'Erreur : $e',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Chargement du profil...'),
            ],
          ),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text('Erreur profil : $e'),
            ],
          ),
        ),
      ),
    );
  }
}