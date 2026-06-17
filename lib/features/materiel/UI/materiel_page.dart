import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import '../provider/materiel_provider.dart';
import '../widgets/materiel_card.dart';
import 'materiel_detail_page.dart';
import 'materiel_form_page.dart';
import '../../../shared/widgets/empty_state.dart';

class MaterielPage extends ConsumerStatefulWidget {
  final String? initialCategorieId;

  const MaterielPage({super.key, this.initialCategorieId});

  @override
  ConsumerState<MaterielPage> createState() => _MaterielPageState();
}

class _MaterielPageState extends ConsumerState<MaterielPage> {
  String? _selectedCategorieId;
  String? _selectedEtat;
  String? _selectedStockId;

  @override
  void initState() {
    super.initState();
    _selectedCategorieId = widget.initialCategorieId;
  }

  final List<String> _etats = [
    'EN_STOCK',
    'EMPRUNTE',
    'AFFECTE',
    'EN_PANNE',
    'REFORME',
  ];

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final stocksAsync = ref.watch(stocksProvider);

    final Map<String, dynamic> filters = {};
    if (_selectedCategorieId != null) filters['id_categorie'] = _selectedCategorieId;
    if (_selectedEtat != null) filters['etat'] = _selectedEtat;
    if (_selectedStockId != null) filters['id_stock'] = _selectedStockId;

    final materielsAsync = ref.watch(materielsProvider(filters.isEmpty ? null : filters));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matériels'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filtres
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.surfaceContainerLow,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoriesAsync.when(
                    data: (cats) => DropdownButton<String>(
                      hint: const Text('Catégorie'),
                      value: _selectedCategorieId,
                      onChanged: (val) => setState(() => _selectedCategorieId = val),
                      items: [
                        const DropdownMenuItem<String>(value: null, child: Text('Toutes catégories')),
                        ...cats.map((c) => DropdownMenuItem<String>(
                              value: c['id_categorie']?.toString(),
                              child: Text(c['nom']?.toString() ?? ''),
                            ))
                      ],
                    ),
                    loading: () => const SizedBox(width: 80, height: 20, child: LinearProgressIndicator()),
                    error: (e, _) => const Text('Erreur catégories'),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    hint: const Text('État'),
                    value: _selectedEtat,
                    onChanged: (val) => setState(() => _selectedEtat = val),
                    items: [
                      const DropdownMenuItem<String>(value: null, child: Text('Tous états')),
                      ..._etats.map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                    ],
                  ),
                  const SizedBox(width: 16),
                  stocksAsync.when(
                    data: (stocks) => DropdownButton<String>(
                      hint: const Text('Stock'),
                      value: _selectedStockId,
                      onChanged: (val) => setState(() => _selectedStockId = val),
                      items: [
                        const DropdownMenuItem<String>(value: null, child: Text('Tous stocks')),
                        ...stocks.map((s) => DropdownMenuItem<String>(
                              value: s['id_stock']?.toString(),
                              child: Text(s['nom']?.toString() ?? ''),
                            ))
                      ],
                    ),
                    loading: () => const SizedBox(width: 80, height: 20, child: LinearProgressIndicator()),
                    error: (e, _) => const Text('Erreur stocks'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: materielsAsync.when(
              data: (mats) {
                if (mats.isEmpty) {
                  return const EmptyState(
                    message: 'Aucun matériel trouvé',
                    subMessage: 'Essayez de modifier les filtres.',
                    icon: Icons.devices_outlined,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: mats.length,
                  itemBuilder: (c, i) {
                    final m = mats[i];
                    final id = m['id_materiel']?.toString() ?? '';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MaterielCard(
                        id: id,
                        nom: m['nom']?.toString() ?? '',
                        reference: m['reference']?.toString() ?? '',
                        etat: m['etat']?.toString() ?? '',
                        description: m['description']?.toString(),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MaterielDetailPage(id: id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Chargement des matériels...'),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: profileAsync.when(
        data: (user) {
          if (user.role == AppConstants.roleAdmin) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MaterielFormPage(),
                  ),
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            );
          }
          return null;
        },
        loading: () => null,
        error: (e, _) => null,
      ),
    );
  }
}