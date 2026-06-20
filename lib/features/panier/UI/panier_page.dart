import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/feedback_card.dart'; // ✅ Ajouter cet import
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/panier_provider.dart';
import '../widgets/categorie_card.dart';

class PanierPage extends ConsumerStatefulWidget {
  const PanierPage({super.key});

  @override
  ConsumerState<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends ConsumerState<PanierPage> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesDisponiblesProvider);
    final panier = ref.watch(panierProvider);
    final isLoading = categoriesAsync.isLoading;

    return Scaffold(
      body: Column(
        children: [
          Toolbar(
            showDetail: false,
            onSearch: (v) => setState(() => _search = v),
            onToggleDetail: () {},
            onRefresh: () => ref.refresh(categoriesDisponiblesProvider),
            creer: null,
          ),
          const Divider(height: 1),

          SizedBox(
            height: 2,
            child: isLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
          ),

          Expanded(
            child: categoriesAsync.when(
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Chargement du catalogue...'),
                  ],
                ),
              ),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text('Erreur : $e'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(categoriesDisponiblesProvider),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
              data: (cats) {
                final filtered = cats.where((cat) {
                  final nom = cat['nom']?.toString() ?? '';
                  final desc = cat['description']?.toString() ?? '';
                  final search = _search.toLowerCase();
                  return nom.toLowerCase().contains(search) ||
                      desc.toLowerCase().contains(search);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: EmptyState(
                      message: _search.isEmpty
                          ? 'Aucune catégorie disponible'
                          : 'Aucun résultat pour "$_search"',
                      subMessage: _search.isEmpty
                          ? 'Aucun matériel disponible pour le moment.'
                          : 'Essayez une autre recherche.',
                      icon: Icons.category_outlined,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.refresh(categoriesDisponiblesProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final cat = filtered[index];
                      final id = cat['id_categorie']?.toString() ?? '';
                      final nom = cat['nom']?.toString() ?? 'Catégorie';
                      final desc = cat['description']?.toString() ?? '';
                      final materiels = (cat['materiels'] as List<dynamic>?)
                              ?.whereType<Map<String, dynamic>>()
                              .toList() ?? [];
                      final dispoCount = materiels.length;
                      final imageUrl = cat['image_url']?.toString();

                      final existing = panier.lignes.firstWhere(
                        (l) => l['id_categorie']?.toString() == id,
                        orElse: () => {},
                      );
                      final currentQuantite = (existing['quantite'] as int?) ?? 0;
                      final canAdd = currentQuantite < dispoCount;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CategorieCard(
                          name: nom,
                          description: desc,
                          dispoCount: dispoCount,
                          imageUrl: imageUrl,
                          currentQuantite: currentQuantite,
                          onAdd: !canAdd
                              ? null
                              : () {
                                  final success = ref.read(panierProvider.notifier).addCategorie(
                                        id,
                                        nom,
                                        dispoCount,
                                        quantite: 1,
                                      );
                                  if (success) {
                                    AppSnackBar.show(
                                      context,
                                      message: '$nom ajouté au panier',
                                      type: FeedbackType.success,
                                      duration: const Duration(seconds: 1),
                                    );
                                  } else {
                                    AppSnackBar.show(
                                      context,
                                      message: 'Quantité maximale atteinte pour $nom',
                                      type: FeedbackType.error,
                                    );
                                  }
                                },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Bottom bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: panier.lignes.isEmpty
                    ? null
                    : () => context.push('/panier'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: panier.lignes.isEmpty
                      ? Colors.grey.shade300
                      : AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: panier.lignes.isEmpty ? Colors.grey.shade600 : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Voir mon panier (${panier.lignes.fold<int>(0, (sum, item) => sum + ((item["quantite"] as int?) ?? 1))})',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: panier.lignes.isEmpty ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}