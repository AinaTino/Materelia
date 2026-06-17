import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/zone_provider.dart';
import 'zone_form_page.dart';

class ZonePage extends ConsumerStatefulWidget {
  const ZonePage({super.key});

  @override
  ConsumerState<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends ConsumerState<ZonePage> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final zonesAsync = ref.watch(zonesProvider);
    final actionState = ref.watch(zoneCrudProvider);
    final isLoading = zonesAsync.isLoading;

    return Scaffold(
      body: Column(
        children: [
          Toolbar(
            showDetail: false,
            onSearch: (v) => setState(() => _search = v),
            onToggleDetail: () {},
            onRefresh: () => ref.invalidate(zonesProvider),
            creer: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ZoneFormPage(),
                ),
              );
            },
          ),
          const Divider(height: 1),

          if (actionState.hasError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FeedbackCard(
                type: FeedbackType.error,
                message: '${actionState.error}',
                dense: true,
              ),
            ),

          SizedBox(
            height: 2,
            child: isLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
          ),

          Expanded(
            child: zonesAsync.when(
              loading: () => const AppLoading(),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(zonesProvider),
              ),
              data: (zones) {
                // Filtrer par recherche
                var filtered = zones;
                if (_search.isNotEmpty) {
                  final search = _search.toLowerCase();
                  filtered = filtered.where((z) {
                    final nom = z['nom']?.toString().toLowerCase() ?? '';
                    final desc = z['description']?.toString().toLowerCase() ?? '';
                    return nom.contains(search) || desc.contains(search);
                  }).toList();
                }

                if (filtered.isEmpty) {
                  return Center(
                    child: EmptyState(
                      message: 'Aucune zone',
                      subMessage: _search.isEmpty
                          ? 'Créez votre première zone.'
                          : 'Aucun résultat pour "$_search"',
                      icon: Icons.map_outlined,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(zonesProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final z = filtered[index];
                      final id = z['id_zone']?.toString() ?? '';
                      final nom = z['nom']?.toString() ?? '';
                      final desc = z['description']?.toString() ?? 'Aucune description';

                      return Card(
                        elevation: 2,
                        shadowColor: Colors.black.withAlpha(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.map_outlined,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nom,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    if (desc.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        desc,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ZoneFormPage(
                                            id: id,
                                            initialNom: nom,
                                            initialDesc: desc,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.error,
                                      size: 20,
                                    ),
                                    onPressed: actionState.isLoading
                                        ? null
                                        : () async {
                                            final confirm = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                title: const Text('Supprimer la zone'),
                                                content: Text(
                                                  'Voulez-vous vraiment supprimer la zone "$nom" ?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: const Text('Annuler'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors.error,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () => Navigator.pop(context, true),
                                                    child: const Text(
                                                      'Supprimer',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (confirm == true && context.mounted) {
                                              try {
                                                await ref.read(zoneCrudProvider.notifier).delete(id);
                                                if (context.mounted) {
                                                  AppSnackBar.show(
                                                    context,
                                                    message: 'Zone supprimée',
                                                    type: FeedbackType.success,
                                                  );
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}