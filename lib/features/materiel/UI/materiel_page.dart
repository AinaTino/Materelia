import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/filtre_chips.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';
import '../provider/materiel_provider.dart';
import '../widgets/materiel_card.dart';
import 'materiel_detail_page.dart';
import 'materiel_form_page.dart';

class MaterielPage extends ConsumerStatefulWidget {
  final String? initialCategorieId;

  const MaterielPage({super.key, this.initialCategorieId});

  @override
  ConsumerState<MaterielPage> createState() => _MaterielPageState();
}

class _MaterielPageState extends ConsumerState<MaterielPage> {
  String _search = '';
  String? _filtreEtat;
  String? _filtreCategorie;

  final Map<String, String> _etats = {
    'EN_STOCK': 'En stock',
    'EMPRUNTE': 'Emprunté',
    'AFFECTE': 'Affecté',
    'EN_PANNE': 'En panne',
    'REFORME': 'Réformé',
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialCategorieId != null) {
      _filtreCategorie = widget.initialCategorieId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final isLoading = profileAsync.isLoading;

    // Build filters
    final Map<String, dynamic> filters = {};
    if (_filtreCategorie != null) filters['id_categorie'] = _filtreCategorie;
    if (_filtreEtat != null) filters['etat'] = _filtreEtat;

    final materielsAsync = ref.watch(materielsProvider(filters.isEmpty ? null : filters));
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      body: profileAsync.when(
        loading: () => const Center(child: AppLoading()),
        error: (e, _) => Center(
          child: ErrorView(
            message: e.toString(),
            onRetry: () => ref.invalidate(profileControllerProvider),
          ),
        ),
        data: (user) {
          final isAdmin = user.role == AppConstants.roleAdmin;

          return Column(
            children: [
              Toolbar(
                showDetail: false,
                onSearch: (v) => setState(() => _search = v),
                onToggleDetail: () {},
                onRefresh: () => ref.invalidate(materielsProvider(filters.isEmpty ? null : filters)),
                creer: isAdmin
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MaterielFormPage(),
                          ),
                        );
                      }
                    : null,
              ),
              const Divider(height: 1),

              // Filtres
              categoriesAsync.when(
                data: (cats) {
                  final categoriesMap = {
                    '': 'Toutes catégories',
                    for (final cat in cats)
                      cat['id_categorie']?.toString() ?? '': cat['nom']?.toString() ?? '',
                  };

                  return Column(
                    children: [
                      FiltreChips(
                        filtreActif: _filtreEtat,
                        etats: _etats,
                        onFiltreChange: (etat) => setState(() => _filtreEtat = etat),
                      ),
                      const Divider(height: 1),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Row(
                          children: [
                            const Text('Catégorie: '),
                            ...categoriesMap.entries.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  label: Text(e.value),
                                  selected: _filtreCategorie == e.key,
                                  onSelected: (_) => setState(
                                    () => _filtreCategorie = _filtreCategorie == e.key ? null : e.key,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, _) => const SizedBox.shrink(),
              ),
              const Divider(height: 1),

              SizedBox(
                height: 2,
                child: isLoading
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),

              Expanded(
                child: materielsAsync.when(
                  loading: () => const AppLoading(),
                  error: (e, _) => ErrorView(
                    message: e.toString(),
                    onRetry: () => ref.invalidate(materielsProvider(filters.isEmpty ? null : filters)),
                  ),
                  data: (mats) {
                    // Filtrer par recherche
                    var filtered = mats;
                    if (_search.isNotEmpty) {
                      final search = _search.toLowerCase();
                      filtered = filtered.where((m) {
                        final nom = m['nom']?.toString().toLowerCase() ?? '';
                        final ref = m['reference']?.toString().toLowerCase() ?? '';
                        return nom.contains(search) || ref.contains(search);
                      }).toList();
                    }

                    if (filtered.isEmpty) {
                      return Center(
                        child: EmptyState(
                          message: 'Aucun matériel trouvé',
                          subMessage: 'Essayez de modifier les filtres.',
                          icon: Icons.devices_outlined,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async => ref.invalidate(materielsProvider(filters.isEmpty ? null : filters)),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final m = filtered[index];
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
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}