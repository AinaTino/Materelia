import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/stock_provider.dart';
import 'stock_form_page.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<StockPage> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final stocksAsync = ref.watch(stocksListProvider);
    final actionState = ref.watch(stockCrudProvider);
    final isLoading = stocksAsync.isLoading;

    return Scaffold(
      body: Column(
        children: [
          Toolbar(
            showDetail: false,
            onSearch: (v) => setState(() => _search = v),
            onToggleDetail: () {},
            onRefresh: () => ref.invalidate(stocksListProvider),
            creer: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StockFormPage(),
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
            child: stocksAsync.when(
              loading: () => const AppLoading(),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(stocksListProvider),
              ),
              data: (stocks) {
                // Filtrer par recherche
                var filtered = stocks;
                if (_search.isNotEmpty) {
                  final search = _search.toLowerCase();
                  filtered = filtered.where((s) {
                    final nom = s['nom']?.toString().toLowerCase() ?? '';
                    final zone = s['zones'] as Map<String, dynamic>?;
                    final zoneNom = zone?['nom']?.toString().toLowerCase() ?? '';
                    return nom.contains(search) || zoneNom.contains(search);
                  }).toList();
                }

                if (filtered.isEmpty) {
                  return Center(
                    child: EmptyState(
                      message: 'Aucun stock',
                      subMessage: _search.isEmpty
                          ? 'Créez votre premier stock.'
                          : 'Aucun résultat pour "$_search"',
                      icon: Icons.warehouse_outlined,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(stocksListProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final s = filtered[index];
                      final id = s['id_stock']?.toString() ?? '';
                      final nom = s['nom']?.toString() ?? '';
                      final zone = s['zones'] as Map<String, dynamic>?;
                      final zoneNom = zone?['nom']?.toString() ?? 'Sans zone';
                      final zoneId = zone?['id_zone']?.toString();

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
                                  Icons.warehouse_outlined,
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
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: Colors.grey.shade500,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          zoneNom,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          builder: (_) => StockFormPage(
                                            id: id,
                                            initialNom: nom,
                                            initialZoneId: zoneId,
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
                                                title: const Text('Supprimer le stock'),
                                                content: Text(
                                                  'Voulez-vous vraiment supprimer le stock "$nom" ?',
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
                                                await ref.read(stockCrudProvider.notifier).delete(id);
                                                if (context.mounted) {
                                                  AppSnackBar.show(
                                                    context,
                                                    message: 'Stock supprimé',
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