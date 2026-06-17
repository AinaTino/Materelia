import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/theme/app_colors.dart';
import '../provider/panier_provider.dart';
import '../widgets/categorie_card.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/toolbar.dart';
import '../../../shared/widgets/feedback_card.dart';
import '../../../shared/widgets/loading.dart';
import '../../../shared/widgets/error_view.dart';

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
              loading: () => const AppLoading(),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.refresh(categoriesDisponiblesProvider),
              ),
              data: (cats) {
                // Filtrer par recherche
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
                              .toList() ??
                          [];
                      final dispoCount = materiels.length;
                      final imageUrl = cat['image_url']?.toString();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CategorieCard(
                          name: nom,
                          description: desc,
                          dispoCount: dispoCount,
                          imageUrl: imageUrl,
                          onAdd: dispoCount == 0
                              ? null
                              : () {
                                  ref.read(panierProvider.notifier).addCategorie(id, nom, quantite: 1);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('$nom ajouté au panier'),
                                      backgroundColor: AppColors.success,
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
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