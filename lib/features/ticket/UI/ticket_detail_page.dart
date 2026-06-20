import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import '../provider/ticket_provider.dart';

class TicketDetailPage extends ConsumerStatefulWidget {
  final String ticketId;
  const TicketDetailPage({super.key, required this.ticketId});

  @override
  ConsumerState<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends ConsumerState<TicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    final ticketAsync = ref.watch(ticketDetailProvider(widget.ticketId));
    final categoriesAsync = ref.watch(ticketCategoriesProvider(widget.ticketId));
    final materielsRemisAsync = ref.watch(ticketMaterielsRemisProvider(widget.ticketId));
    final profileAsync = ref.watch(profileControllerProvider);
    final actionState = ref.watch(ticketActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du ticket'),
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (user) {
          final isTechOrAdmin = user.role == AppConstants.roleTechnicien ||
              user.role == AppConstants.roleAdmin;

          return ticketAsync.when(
            data: (ticket) {
              final id = ticket['id_ticket']?.toString() ?? '';
              final etat = ticket['etat']?.toString() ?? '';
              final lieu = ticket['lieu_utilisation']?.toString() ?? '';
              final codeRemise = ticket['code_remise']?.toString() ?? '';
              final dateFinRaw = ticket['date_fin_prevue']?.toString();
              final dateFin = dateFinRaw != null ? DateTime.parse(dateFinRaw) : null;
              final dateFinStr = dateFin != null
                  ? '${dateFin.day.toString().padLeft(2, '0')}/${dateFin.month.toString().padLeft(2, '0')}/${dateFin.year}'
                  : '';

              final estApresRemise = etat == 'EN_COURS' || etat == 'RENDU';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Info Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ticket #${id.substring(0, 8).toUpperCase()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                BadgeEtat.string(etat: etat),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Lieu d\'utilisation :'),
                                Text(lieu, style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Retour prévu le :'),
                                Text(dateFinStr, style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            if (codeRemise.isNotEmpty &&
                                etat != 'RENDU' &&
                                etat != 'REFUSE' &&
                                etat != 'EXPIRE') ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.qr_code, color: AppColors.primary),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Code : $codeRemise',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section des matériels/catégories
                    Text(
                      estApresRemise
                          ? 'Matériels remis'
                          : 'Catégories demandées',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: estApresRemise ? AppColors.success : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Expanded(
                      child: estApresRemise
                          ? materielsRemisAsync.when(
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, _) => Center(child: Text('Erreur: $e')),
                              data: (lignes) {
                                if (lignes.isEmpty) {
                                  return const Center(
                                    child: Text('Aucun matériel remis'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: lignes.length,
                                  itemBuilder: (context, idx) {
                                    final l = lignes[idx];
                                    final mat = l['materiels'] as Map<String, dynamic>?;
                                    final matName = mat?['nom'] ?? 'Matériel inconnu';
                                    final matRef = mat?['reference'] ?? '';

                                    return Card(
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      child: ListTile(
                                        leading: const Icon(Icons.devices, color: AppColors.primary),
                                        title: Text(matName),
                                        subtitle: Text('Réf : $matRef'),
                                        trailing: const Icon(
                                          Icons.check_circle,
                                          color: AppColors.success,
                                          size: 20,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : categoriesAsync.when(
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, _) => Center(child: Text('Erreur: $e')),
                              data: (categories) {
                                if (categories.isEmpty) {
                                  return const Center(
                                    child: Text('Aucune catégorie demandée'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder: (context, idx) {
                                    final cat = categories[idx];
                                    final catData = cat['categories'] as Map<String, dynamic>?;
                                    final catName = catData?['nom'] ?? 'Catégorie';
                                    final quantite = cat['quantite'] ?? 1;

                                    return Card(
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      child: ListTile(
                                        leading: const Icon(Icons.category, color: AppColors.primary),
                                        title: Text(catName),
                                        subtitle: Text('Quantité: $quantite - En attente'),
                                        trailing: const Icon(
                                          Icons.hourglass_empty,
                                          color: AppColors.warning,
                                          size: 20,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),

                    if (actionState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Erreur : ${actionState.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // Message pour l'utilisateur Simple
                    if (!isTechOrAdmin &&
                        codeRemise.isNotEmpty &&
                        etat != 'RENDU' &&
                        etat != 'REFUSE' &&
                        etat != 'EXPIRE') ...[
                      const SizedBox(height: 12),
                      Card(
                        color: AppColors.infoContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              Icon(Icons.info_outline, color: AppColors.info),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Présentez ce code au technicien pour récupérer le matériel.',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Message pour le technicien
                    if (isTechOrAdmin &&
                        (etat == 'EN_ATTENTE' || etat == 'VALIDE') &&
                        codeRemise.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        color: AppColors.warningContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_forward, color: AppColors.warning),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  'Pour traiter ce ticket, allez dans la section "Tickets Zone" et utilisez le formulaire de remise.',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erreur ticket detail : $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur profile : $e')),
      ),
    );
  }
}