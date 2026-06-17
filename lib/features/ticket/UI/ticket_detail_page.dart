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
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketAsync = ref.watch(ticketDetailProvider(widget.ticketId));
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

              final lignes = (ticket['lignes_ticket'] as List<dynamic>?) ?? [];

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
                            // Affichage du code pour tout le monde
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
                    const Text(
                      'Matériels demandés',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
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
                            ),
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

                    // ──────────────────────────────────────────────
                    // ACTIONS POUR LE TECHNICIEN / ADMIN
                    // ──────────────────────────────────────────────

                    // ✅ Le technicien/admin peut confirmer la remise
                    //    en saisissant le code (état EN_ATTENTE ou VALIDE)
                    if (isTechOrAdmin &&
                        (etat == 'EN_ATTENTE' || etat == 'VALIDE') &&
                        codeRemise.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        elevation: 2,
                        color: AppColors.surfaceContainerLow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Confirmer la remise du matériel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Saisissez le code de remise fourni par l\'utilisateur.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _codeController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Code de remise (6 chiffres)',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                        ),
                                        validator: (val) {
                                          if (val == null || val.length != 6) {
                                            return 'Code à 6 chiffres requis';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 24,
                                        ),
                                        backgroundColor: AppColors.success,
                                      ),
                                      onPressed: actionState.isLoading
                                          ? null
                                          : () async {
                                              if (_formKey.currentState?.validate() ?? false) {
                                                try {
                                                  await ref
                                                      .read(ticketActionProvider.notifier)
                                                      .confirmerRemise(
                                                        id,
                                                        _codeController.text.trim(),
                                                        user.id,
                                                        userId: user.id,
                                                      );
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Remise confirmée'),
                                                        backgroundColor: Colors.green,
                                                      ),
                                                    );
                                                    _codeController.clear();
                                                  }
                                                } catch (e) {
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Erreur : $e'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                      child: actionState.isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              'Confirmer la remise',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],

                    // ✅ Le technicien/admin peut confirmer le retour
                    //    quand le ticket est EN_COURS
                    if (isTechOrAdmin && etat == 'EN_COURS') ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: actionState.isLoading
                              ? null
                              : () async {
                                  try {
                                    await ref
                                        .read(ticketActionProvider.notifier)
                                        .confirmReturn(id, user.id, userId: user.id);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Retour confirmé !'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Erreur : $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                          child: actionState.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text(
                                  'Confirmer le retour physique',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],

                    // ✅ Message pour l'utilisateur Simple
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