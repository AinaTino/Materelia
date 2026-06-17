import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/services/supabase_service.dart';
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
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Panier vide',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ajoutez des catégories depuis le catalogue',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          '${panier.lignes.length} article(s)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: panier.lignes.length,
                        itemBuilder: (c, i) {
                          final l = panier.lignes[i];
                          final catId = l['id_categorie']?.toString() ?? '';
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryContainer,
                                child: Text(
                                  '${l['quantite'] ?? 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              title: Text(l['nom'] ?? 'Catégorie'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                onPressed: () {
                                  ref.read(panierProvider.notifier).removeCategorie(catId);
                                },
                              ),
                            ),
                          );
                        },
                      ),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Le lieu d\'utilisation est requis'),
                                      backgroundColor: AppColors.error,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }
                                if (_dateFin == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('La date de fin est requise'),
                                      backgroundColor: AppColors.error,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }

                                if (_formKey.currentState?.validate() ?? false) {
                                  final messenger = ScaffoldMessenger.of(context);
                                  final user = SupabaseService.currentUser;
                                  if (user == null) {
                                    messenger.showSnackBar(
                                      const SnackBar(
                                        content: Text('Utilisateur non connecté'),
                                        backgroundColor: AppColors.error,
                                      ),
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
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Demande soumise avec succès !'),
                                          backgroundColor: AppColors.success,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text('Erreur : $e'),
                                        backgroundColor: AppColors.error,
                                        behavior: SnackBarBehavior.floating,
                                      ),
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
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Confirmer la demande',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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