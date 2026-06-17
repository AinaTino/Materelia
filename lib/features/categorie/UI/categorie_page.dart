import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/categorie_provider.dart';
import 'categorie_form_page.dart';

class CategoriePage extends ConsumerStatefulWidget {
  const CategoriePage({super.key});

  @override
  ConsumerState<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends ConsumerState<CategoriePage> {
  String _search = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final actionState = ref.watch(categorieCrudProvider);
    final isLoading = categoriesAsync.isLoading;

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Toolbar(
            showDetail: false,
            onSearch: (v) => setState(() => _search = v),
            onToggleDetail: () {},
            onRefresh: () => ref.invalidate(categoriesProvider),
            creer: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CategorieFormPage(),
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
            child: categoriesAsync.when(
              loading: () => const AppLoading(),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(categoriesProvider),
              ),
              data: (categories) {
                // Filtrer par recherche
                var filtered = categories;
                if (_search.isNotEmpty) {
                  final search = _search.toLowerCase();
                  filtered = filtered.where((c) {
                    final nom = c['nom']?.toString().toLowerCase() ?? '';
                    final desc = c['description']?.toString().toLowerCase() ?? '';
                    return nom.contains(search) || desc.contains(search);
                  }).toList();
                }

                if (filtered.isEmpty) {
                  return Center(
                    child: EmptyState(
                      message: 'Aucune catégorie',
                      subMessage: _search.isEmpty
                          ? 'Créez votre première catégorie.'
                          : 'Aucun résultat pour "$_search"',
                      icon: Icons.category_outlined,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(categoriesProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final c = filtered[index];
                      final id = c['id_categorie']?.toString() ?? '';
                      final nom = c['nom']?.toString() ?? '';
                      final desc = c['description']?.toString() ?? 'Aucune description';
                      final imageUrl = c['image_url']?.toString();

                      return Card(
                        elevation: 2,
                        shadowColor: Colors.black.withAlpha(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            color: AppColors.surfaceContainer,
                                            child: const Icon(
                                              Icons.category,
                                              color: AppColors.primary,
                                              size: 30,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          color: AppColors.surfaceContainer,
                                          child: const Icon(
                                            Icons.category,
                                            color: AppColors.primary,
                                            size: 30,
                                          ),
                                        ),
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
                                          builder: (_) => CategorieFormPage(
                                            id: id,
                                            initialNom: nom,
                                            initialDesc: desc,
                                            initialImageUrl: imageUrl,
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
                                                title: const Text('Supprimer la catégorie'),
                                                content: Text(
                                                  'Voulez-vous vraiment supprimer la catégorie "$nom" ?',
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
                                                await ref.read(categorieCrudProvider.notifier).delete(id);
                                                if (context.mounted) {
                                                  AppSnackBar.show(
                                                    context,
                                                    message: 'Catégorie supprimée',
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