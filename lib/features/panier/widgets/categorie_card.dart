import 'package:flutter/material.dart';
import 'package:materelia/core/theme/app_colors.dart';

class CategorieCard extends StatelessWidget {
  final String name;
  final String? description;
  final int dispoCount;
  final String? imageUrl;
  final int currentQuantite;
  final VoidCallback? onAdd;

  const CategorieCard({
    super.key,
    required this.name,
    this.description,
    required this.dispoCount,
    this.imageUrl,
    this.currentQuantite = 0,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final canAdd = onAdd != null && currentQuantite < dispoCount;

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withAlpha(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 72,
                height: 72,
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceContainer,
                          child: const Icon(
                            Icons.category,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.surfaceContainer,
                            child: const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
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
                          size: 32,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),

            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Badge de disponibilité
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: dispoCount > 0
                              ? AppColors.successContainer
                              : AppColors.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              dispoCount > 0 ? Icons.check_circle : Icons.block,
                              size: 14,
                              color: dispoCount > 0 ? AppColors.success : AppColors.error,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              dispoCount > 0 ? '$dispoCount' : '0',
                              style: TextStyle(
                                color: dispoCount > 0 ? AppColors.success : AppColors.error,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (currentQuantite > 0) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$currentQuantite dans le panier',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // ✅ Bouton Ajouter à droite
            const SizedBox(width: 8),
            if (canAdd)
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onAdd,
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
              Container(
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