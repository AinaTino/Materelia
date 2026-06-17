import 'package:flutter/material.dart';
import 'package:materelia/core/theme/app_colors.dart';

class Toolbar extends StatelessWidget {
  final bool showDetail;
  final ValueChanged<String> onSearch;
  final VoidCallback onToggleDetail;
  final VoidCallback onRefresh;
  final VoidCallback? creer;

  const Toolbar({
    super.key,
    required this.showDetail,
    required this.onSearch,
    required this.onToggleDetail,
    required this.onRefresh,
    required this.creer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search, size: 18),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: onSearch,
            ),
          ),
          const SizedBox(width: 8),
          if (creer != null) ...{
            IconButton.outlined(
              icon: const Icon(Icons.add),
              tooltip: 'Nouveau',
              onPressed: creer,
              color: AppColors.inversePrimary,
            ),
          },
          const SizedBox(width: 8),
          IconButton.outlined(
            icon: const Icon(Icons.refresh),
            tooltip: 'Rafraîchir',
            onPressed: onRefresh,
          ),
          const SizedBox(width: 8),
          IconButton.outlined(
            icon: Icon(showDetail ? Icons.view_list : Icons.table_rows),
            tooltip: showDetail ? 'Masquer panneau' : 'Afficher panneau',
            onPressed: onToggleDetail,
          ),
        ],
      ),
    );
  }
}
