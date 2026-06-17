import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/ticket_provider.dart';

class TicketsZonePage extends ConsumerStatefulWidget {
  const TicketsZonePage({super.key});

  @override
  ConsumerState<TicketsZonePage> createState() => _TicketsZonePageState();
}

class _TicketsZonePageState extends ConsumerState<TicketsZonePage> {
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
          appBar: AppBar(
            title: const Text('Gestion des tickets'),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Carte 1 : Remise du matériel
                Card(
                  elevation: 2,
                  shadowColor: Colors.black.withAlpha(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
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
                                        try {
                                          await ref
                                              .read(ticketActionProvider.notifier)
                                              .confirmerRemiseParCode(
                                                code,
                                                user.id,
                                                userId: user.id,
                                              );
                                          if (context.mounted) {
                                            AppSnackBar.show(
                                              context,
                                              message: 'Remise confirmée avec succès',
                                              type: FeedbackType.success,
                                            );
                                            _remiseCodeController.clear();
                                          }
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

                // Carte 2 : Retour du matériel
                Card(
                  elevation: 2,
                  shadowColor: Colors.black.withAlpha(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.white,
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
                                            _retourCodeController.clear();
                                          }
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
}