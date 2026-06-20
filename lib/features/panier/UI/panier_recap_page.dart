import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/services/supabase_service.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import '../provider/panier_provider.dart';

class PanierRecapPage extends ConsumerStatefulWidget {
  const PanierRecapPage({super.key});

  @override
  ConsumerState<PanierRecapPage> createState() => _PanierRecapPageState();
}

class _PanierRecapPageState extends ConsumerState<PanierRecapPage> {
  final _formKey = GlobalKey<FormState>();
  final _lieuController = TextEditingController();
  DateTime? _dateFin;

  @override
  void dispose() {
    _lieuController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dateFin) {
      setState(() {
        _dateFin = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final panier = ref.watch(panierProvider);
    final actionState = ref.watch(panierActionProvider);

    final dateFinStr = _dateFin != null
        ? '${_dateFin!.day.toString().padLeft(2, '0')}/${_dateFin!.month.toString().padLeft(2, '0')}/${_dateFin!.year}'
        : 'Choisir la date de fin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: panier.lignes.isEmpty
            ? Center(
                child: FeedbackCard(
                  icon: Icons.shopping_cart_outlined,
                  type: FeedbackType.warning,
                  title: 'Panier vide',
                  message: 'Ajoutez des catégories depuis le catalogue.',
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catégories sélectionnées',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: panier.lignes.length,
                      itemBuilder: (c, i) {
                        final l = panier.lignes[i];
                        final catId = l['id_categorie']?.toString() ?? '';
                        final quantite = (l['quantite'] as int?) ?? 1;
                        final dispoMax = (l['dispoMax'] as int?) ?? 0;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryContainer,
                                  child: Text(
                                    '$quantite',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l['nom'] ?? 'Catégorie',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Max: $dispoMax disponible(s)',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      color: quantite > 1 ? AppColors.primary : Colors.grey,
                                      onPressed: quantite > 1
                                          ? () {
                                              final success = ref
                                                  .read(panierProvider.notifier)
                                                  .updateQuantite(catId, quantite - 1);
                                              if (!success) {
                                                AppSnackBar.show(
                                                  context,
                                                  message: 'Quantité minimale atteinte',
                                                  type: FeedbackType.error,
                                                );
                                              }
                                            }
                                          : null,
                                    ),
                                    Text(
                                      '$quantite',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      color: quantite < dispoMax ? AppColors.primary : Colors.grey,
                                      onPressed: quantite < dispoMax
                                          ? () {
                                              final success = ref
                                                  .read(panierProvider.notifier)
                                                  .updateQuantite(catId, quantite + 1);
                                              if (!success) {
                                                AppSnackBar.show(
                                                  context,
                                                  message: 'Quantité maximale atteinte',
                                                  type: FeedbackType.error,
                                                );
                                              }
                                            }
                                          : null,
                                    ),
                                    const SizedBox(width: 4),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                      onPressed: () {
                                        ref.read(panierProvider.notifier).removeCategorie(catId);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 32),

                    const Text(
                      'Informations d\'emprunt',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lieuController,
                      decoration: const InputDecoration(
                        labelText: 'Lieu d\'utilisation *',
                        border: OutlineInputBorder(),
                        hintText: 'Ex: Salle 204, Bureau Exploitation...',
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Veuillez saisir le lieu d\'utilisation';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, color: AppColors.primary),
                                const SizedBox(width: 12),
                                Text(
                                  dateFinStr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _dateFin == null ? Colors.grey.shade600 : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (actionState.hasError)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: AppColors.error),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${actionState.error}',
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: actionState.isLoading
                            ? null
                            : () async {
                                if (_lieuController.text.trim().isEmpty) {
                                  AppSnackBar.show(
                                    context,
                                    message: 'Le lieu d\'utilisation est requis',
                                    type: FeedbackType.error,
                                  );
                                  return;
                                }
                                if (_dateFin == null) {
                                  AppSnackBar.show(
                                    context,
                                    message: 'La date de fin est requise',
                                    type: FeedbackType.error,
                                  );
                                  return;
                                }

                                if (_formKey.currentState?.validate() ?? false) {
                                  final user = SupabaseService.currentUser;
                                  if (user == null) {
                                    AppSnackBar.show(
                                      context,
                                      message: 'Utilisateur non connecté',
                                      type: FeedbackType.error,
                                    );
                                    return;
                                  }

                                  try {
                                    await ref.read(panierActionProvider.notifier).validatePanier(
                                          userId: user.id,
                                          lieu: _lieuController.text.trim(),
                                          dateFin: _dateFin!,
                                        );
                                    if (context.mounted) {
                                      context.go('/mes-tickets');
                                      AppSnackBar.show(
                                        context,
                                        message: 'Demande soumise avec succès',
                                        type: FeedbackType.success,
                                      );
                                    }
                                  } catch (e) {
                                    AppSnackBar.show(
                                      context,
                                      message: 'Erreur: $e',
                                      type: FeedbackType.error,
                                    );
                                  }
                                }
                              },
                        child: actionState.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Confirmer la demande',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}