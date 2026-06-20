import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';
import '../provider/ticket_provider.dart';

class TicketsZonePage extends ConsumerStatefulWidget {
  const TicketsZonePage({super.key});

  @override
  ConsumerState<TicketsZonePage> createState() => _TicketsZonePageState();
}

class _TicketsZonePageState extends ConsumerState<TicketsZonePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _remiseCodeController = TextEditingController();
  final _remiseFormKey = GlobalKey<FormState>();
  final _retourCodeController = TextEditingController();
  final _retourFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _remiseCodeController.dispose();
    _retourCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final actionState = ref.watch(ticketActionProvider);

    return profileAsync.when(
      data: (user) {
        final isTechOrAdmin = user.role == AppConstants.roleTechnicien ||
            user.role == AppConstants.roleAdmin;
        if (!isTechOrAdmin) {
          return Scaffold(
            body: Center(
              child: FeedbackCard(
                icon: Icons.lock_outline,
                type: FeedbackType.warning,
                title: 'Accès réservé',
                message: 'Cette page est réservée aux techniciens et administrateurs.',
              ),
            ),
          );
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Gestion des tickets'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ✅ Carte Remise
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _remiseFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.successContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.qr_code_scanner,
                                  color: AppColors.success,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Remise du matériel',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                      fontSize: 18,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Saisissez le code de remise à 6 chiffres fourni par l\'utilisateur.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _remiseCodeController,
                            decoration: const InputDecoration(
                              labelText: 'Code de remise (6 chiffres)',
                              hintText: 'Ex: 123456',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            validator: (value) {
                              if (value == null || value.length != 6) {
                                return 'Le code doit contenir 6 chiffres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.success,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: actionState.isLoading
                                  ? null
                                  : () async {
                                      if (_remiseFormKey.currentState?.validate() ?? false) {
                                        final code = _remiseCodeController.text.trim();
                                        await _showMaterielSelectionDialog(
                                          context,
                                          code,
                                          user.id,
                                        );
                                      }
                                    },
                              child: actionState.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Confirmer la remise',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Carte Retour
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _retourFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.infoContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.assignment_return,
                                  color: AppColors.info,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Retour du matériel',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                      fontSize: 18,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Saisissez le code de remise du ticket en cours pour confirmer le retour.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _retourCodeController,
                            decoration: const InputDecoration(
                              labelText: 'Code de remise (6 chiffres)',
                              hintText: 'Ex: 123456',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            validator: (value) {
                              if (value == null || value.length != 6) {
                                return 'Le code doit contenir 6 chiffres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: actionState.isLoading
                                  ? null
                                  : () async {
                                      if (_retourFormKey.currentState?.validate() ?? false) {
                                        final code = _retourCodeController.text.trim();
                                        try {
                                          await ref
                                              .read(ticketActionProvider.notifier)
                                              .confirmerRetourParCode(
                                                code,
                                                user.id,
                                                userId: user.id,
                                              );
                                          if (context.mounted) {
                                            AppSnackBar.show(
                                              context,
                                              message: 'Retour confirmé avec succès',
                                              type: FeedbackType.success,
                                            );
                                          }
                                          _retourCodeController.clear();
                                        } catch (e) {
                                          if (context.mounted) {
                                            AppSnackBar.show(
                                              context,
                                              message: 'Erreur: $e',
                                              type: FeedbackType.error,
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
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Confirmer le retour',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: AppLoading()),
      error: (e, _) => Center(
        child: FeedbackCard(
          type: FeedbackType.error,
          message: 'Erreur profile: $e',
        ),
      ),
    );
  }

  // ✅ Dialogue de sélection des matériels
  Future<void> _showMaterielSelectionDialog(
    BuildContext context,
    String code,
    String technicienId,
  ) async {
    try {
      // 1. Trouver le ticket par code
      final ticket = await ref.read(ticketServiceProvider).trouverTicketParCode(code);
      
      if (ticket == null) {
        if (context.mounted) {
          AppSnackBar.show(
            context,
            message: 'Code invalide. Aucun ticket trouvé.',
            type: FeedbackType.error,
          );
        }
        return;
      }

      final ticketId = ticket['id_ticket'];
      final currentEtat = ticket['etat']?.toString() ?? '';

      if (currentEtat == 'RENDU' || currentEtat == 'REFUSE' || currentEtat == 'EXPIRE') {
        if (context.mounted) {
          AppSnackBar.show(
            context,
            message: 'Ce ticket est déjà terminé.',
            type: FeedbackType.error,
          );
        }
        return;
      }

      if (currentEtat == 'EN_COURS') {
        if (context.mounted) {
          AppSnackBar.show(
            context,
            message: 'Ce ticket est déjà en cours de traitement.',
            type: FeedbackType.error,
          );
        }
        return;
      }

      // 2. Récupérer les catégories demandées
      List<Map<String, dynamic>> categories = [];
      try {
        categories = await ref.read(ticketCategoriesProvider(ticketId).future);
      } catch (e) {
        print('Erreur récupération catégories: $e');
      }
      
      if (categories.isEmpty) {
        if (context.mounted) {
          AppSnackBar.show(
            context,
            message: 'Aucune catégorie trouvée pour ce ticket.',
            type: FeedbackType.error,
          );
        }
        return;
      }

      // 3. Calculer le nombre total de matériels demandés
      int totalDemande = 0;
      for (final cat in categories) {
        totalDemande += (cat['quantite'] as int?) ?? 1;
      }

      // 4. Récupérer tous les matériels disponibles
      Map<String, List<Map<String, dynamic>>> materielsParCategorie = {};
      for (final cat in categories) {
        final catId = cat['categorie_id']?.toString() ?? '';
        final catData = cat['categories'] as Map<String, dynamic>?;
        final catNom = catData?['nom'] ?? 'Catégorie';
        
        if (catId.isEmpty) continue;
        
        try {
          final materiels = await ref
              .read(materielsDisponiblesPourCategorieProvider(catId).future);
          
          materielsParCategorie[catId] = materiels.map((mat) => ({
            ...mat,
            'categorie_nom': catNom,
            'categorie_id': catId,
          })).toList();
        } catch (e) {
          print('Erreur récupération matériels pour catégorie $catId: $e');
          materielsParCategorie[catId] = [];
        }
      }

      // 5. État de sélection
      final selectedIds = <String>[];
      String selectedCategorieId = categories.isNotEmpty 
          ? categories.first['categorie_id']?.toString() ?? '' 
          : '';

      if (!context.mounted) return;

      // 6. Afficher le dialogue
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (dialogContext) => StatefulBuilder(
          builder: (dialogContext, setState) {
            // Filtrer les matériels par catégorie sélectionnée
            List<Map<String, dynamic>> materielsFiltres = [];
            if (selectedCategorieId.isNotEmpty && materielsParCategorie.containsKey(selectedCategorieId)) {
              materielsFiltres = materielsParCategorie[selectedCategorieId] ?? [];
            } else {
              for (final mats in materielsParCategorie.values) {
                materielsFiltres.addAll(mats);
              }
            }

            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(dialogContext).size.height * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Attribution des matériels',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Numéro du ticket
                  Text(
                    'Ticket #${ticketId.substring(0, 8).toUpperCase()}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  
                  // Total demandé
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.primary, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Total demandé: $totalDemande matériel(s)',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${selectedIds.length} sélectionné(s)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  const Divider(),
                  const SizedBox(height: 8),

                  // Catégories demandées
                  Text(
                    'Catégories demandées',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primaryContainer),
                    ),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: categories.map((cat) {
                        final catId = cat['categorie_id']?.toString() ?? '';
                        final catData = cat['categories'] as Map<String, dynamic>?;
                        final catNom = catData?['nom'] ?? 'Catégorie';
                        final quantite = cat['quantite'] ?? 1;
                        final isSelected = selectedCategorieId == catId;
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategorieId = catId;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  catNom,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.textPrimary,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : AppColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$quantite',
                                    style: TextStyle(
                                      color: isSelected ? AppColors.primary : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Matériels disponibles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Matériels disponibles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '${selectedIds.length} sélectionné(s)',
                        style: TextStyle(
                          fontSize: 13,
                          color: selectedIds.isNotEmpty ? AppColors.success : Colors.grey.shade600,
                          fontWeight: selectedIds.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: materielsFiltres.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Aucun matériel disponible pour cette catégorie',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: materielsFiltres.length,
                            itemBuilder: (context, index) {
                              final mat = materielsFiltres[index];
                              final id = mat['id_materiel']?.toString() ?? '';
                              final nom = mat['nom']?.toString() ?? 'Inconnu';
                              final refe = mat['reference']?.toString() ?? '';
                              final isSelected = selectedIds.contains(id);

                              return Card(
                                elevation: 0,
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: isSelected ? AppColors.success : Colors.grey.shade200,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: CheckboxListTile(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedIds.add(id);
                                      } else {
                                        selectedIds.remove(id);
                                      }
                                    });
                                  },
                                  title: Text(
                                    nom,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? AppColors.success : AppColors.textPrimary,
                                    ),
                                  ),
                                  subtitle: Text('Réf: $refe'),
                                  secondary: isSelected
                                      ? const Icon(Icons.check_circle, color: AppColors.success)
                                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                                  selected: isSelected,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(),
                  
                  // ✅ Boutons avec AppSnackBar
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Annuler'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedIds.isNotEmpty && selectedIds.length == totalDemande
                                ? AppColors.success
                                : Colors.grey.shade400,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: (selectedIds.isEmpty || selectedIds.length != totalDemande)
                              ? null
                              : () async {
                                  // ✅ Sauvegarder le contexte de la page avant de fermer le dialogue
                                  final pageContext = context;
                                  
                                  // Fermer le dialogue
                                  Navigator.pop(dialogContext);
                                  
                                  try {
                                    await ref
                                        .read(ticketActionProvider.notifier)
                                        .confirmerRemiseAvecMateriels(
                                          code: code,
                                          technicienId: technicienId,
                                          materielIds: selectedIds,
                                        );
                                    
                                    // ✅ Utiliser le contexte de la page pour afficher le toast
                                    if (pageContext.mounted) {
                                      AppSnackBar.show(
                                        pageContext,
                                        message: 'Remise confirmée avec succès',
                                        type: FeedbackType.success,
                                      );
                                      _remiseCodeController.clear();
                                    }
                                  } catch (e) {
                                    if (pageContext.mounted) {
                                      AppSnackBar.show(
                                        pageContext,
                                        message: 'Erreur: $e',
                                        type: FeedbackType.error,
                                      );
                                    }
                                  }
                                },
                          child: Text(
                            'Attribuer (${selectedIds.length})',
                            style: TextStyle(
                              color: selectedIds.isNotEmpty && selectedIds.length == totalDemande
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } catch (e) {
      print('Erreur générale dans _showMaterielSelectionDialog: $e');
      if (context.mounted) {
        AppSnackBar.show(
          context,
          message: 'Erreur: $e',
          type: FeedbackType.error,
        );
      }
    }
  }
}