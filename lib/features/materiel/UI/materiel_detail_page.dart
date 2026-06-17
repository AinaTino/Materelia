import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import '../provider/materiel_provider.dart';
import 'materiel_form_page.dart';

class MaterielDetailPage extends ConsumerWidget {
  final String id;
  const MaterielDetailPage({super.key, required this.id});

  void _showReformConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Réformer le matériel'),
          content: const Text(
            'Êtes-vous sûr de vouloir réformer ce matériel ? Son état passera à RÉFORMÉ et il ne sera plus disponible à l\'emprunt.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () async {
                Navigator.pop(context);
                try {
                  await ref.read(materielCrudProvider.notifier).reform(id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Le matériel a été réformé avec succès')),
                    );
                    Navigator.pop(context); // Go back to list
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur : $e')),
                    );
                  }
                }
              },
              child: const Text('Confirmer la réforme', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materielAsync = ref.watch(materielDetailProvider(id));
    final profileAsync = ref.watch(profileControllerProvider);
    final actionState = ref.watch(materielCrudProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du matériel'),
        elevation: 0,
      ),
      body: profileAsync.when(
        data: (user) {
          final isAdmin = user.role == AppConstants.roleAdmin;

          return materielAsync.when(
            data: (mat) {
              if (mat == null) {
                return const Center(child: Text('Matériel introuvable'));
              }

              final nom = mat['nom']?.toString() ?? 'Sans nom';
              final refCode = mat['reference']?.toString() ?? '';
              final desc = mat['description']?.toString() ?? 'Aucune description';
              final etat = mat['etat']?.toString() ?? 'EN_STOCK';
              final dateAcqRaw = mat['date_acquisition']?.toString();
              final dateAcq = dateAcqRaw != null ? DateTime.parse(dateAcqRaw) : null;
              final dateAcqStr = dateAcq != null
                  ? '${dateAcq.day.toString().padLeft(2, '0')}/${dateAcq.month.toString().padLeft(2, '0')}/${dateAcq.year}'
                  : 'Inconnue';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Info Card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    nom,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                BadgeEtat.string(etat: etat),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Référence : $refCode',
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Divider(height: 32),
                            const Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              desc,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Date d\'acquisition :'),
                                Text(dateAcqStr, style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (actionState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Erreur : ${actionState.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // Admin Actions buttons
                    if (isAdmin) ...[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: actionState.isLoading || etat == 'REFORME'
                                  ? null
                                  : () => _showReformConfirmation(context, ref),
                              child: const Text('Réformer', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: actionState.isLoading
                                  ? null
                                  : () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => MaterielFormPage(id: id),
                                        ),
                                      );
                                    },
                              child: const Text('Modifier', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur matériel : $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur profile : $e')),
      ),
    );
  }
}
