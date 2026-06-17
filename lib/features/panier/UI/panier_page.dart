import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:materelia/core/theme/app_colors.dart';
import '../provider/panier_provider.dart';
import '../../../shared/widgets/empty_state.dart';

class PanierPage extends ConsumerStatefulWidget {
  const PanierPage({super.key});

  @override
  ConsumerState<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends ConsumerState<PanierPage> {
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesDisponiblesProvider);
    final panier = ref.watch(panierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        elevation: 0,
        actions: [
          // Icône panier avec badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.push('/panier'),
              ),
              if (panier.lignes.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${panier.lignes.fold<int>(0, (sum, item) => sum + ((item["quantite"] as int?) ?? 1))}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: categoriesAsync.when(
        data: (cats) {
          if (cats.isEmpty) {
            return const EmptyState(
              message: 'Aucune catégorie disponible',
              subMessage: 'Aucun matériel disponible pour le moment.',
              icon: Icons.category_outlined,
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(categoriesDisponiblesProvider),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                return _buildCategoryCard(cat);
              },
            ),
          );
        },
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
              Text(
                'Erreur : $e',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(categoriesDisponiblesProvider),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
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
    );
  }

  // ===================== CARTE EN LISTE =====================

  Widget _buildCategoryCard(Map<String, dynamic> cat) {
    final id = cat['id_categorie']?.toString() ?? '';
    final nom = cat['nom']?.toString() ?? 'Catégorie';
    final desc = cat['description']?.toString() ?? '';
    final materiels = (cat['materiels'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .toList() ??
        [];
    final dispoCount = materiels.length;
    final imageUrl = cat['image_url']?.toString();

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withAlpha(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Image à gauche
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 70,
                height: 70,
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
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.surfaceContainer,
                            child: const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          );
                        },
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

            // Informations
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          nom,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // ✅ Badge vert foncé sur fond vert clair
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: dispoCount > 0
                              ? AppColors.successContainer // Vert clair
                              : AppColors.errorContainer, // Rouge clair
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          dispoCount > 0 ? '$dispoCount' : '0',
                          style: TextStyle(
                            color: dispoCount > 0
                                ? AppColors.success // Vert foncé
                                : AppColors.error, // Rouge foncé
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (desc.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Bouton Ajouter à droite (icône uniquement)
            if (dispoCount > 0)
              Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    ref.read(panierProvider.notifier).addCategorie(id, nom, quantite: 1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            const SizedBox(width: 8),
                            Text('$nom ajouté au panier'),
                          ],
                        ),
                        backgroundColor: AppColors.success,
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              )
            else
              // Bouton désactivé (indisponible)
              Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.block,
                    color: Colors.grey,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}