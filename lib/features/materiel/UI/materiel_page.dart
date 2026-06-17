import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/widgets/empty_state.dart';
import 'package:materelia/shared/widgets/error_view.dart';
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
    '': 'Tous', // ✅ Ajout de l'option "Tous"
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFilters();
    });
  }

  void _updateFilters() {
    final filters = <String, dynamic>{};
    if (_filtreCategorie != null && _filtreCategorie!.isNotEmpty) {
      filters['id_categorie'] = _filtreCategorie;
    }
    if (_filtreEtat != null && _filtreEtat!.isNotEmpty) {
      filters['etat'] = _filtreEtat;
    }
    ref.read(materielFiltersProvider.notifier).setFilters(filters.isEmpty ? null : filters);
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);
    final materielsAsync = ref.watch(materielsProvider);
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
                onSearch: (v) => setState(() {
                  _search = v;
                }),
                onToggleDetail: () {},
                onRefresh: () {
                  ref.invalidate(materielsProvider);
                },
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: Colors.grey.shade50,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Si l'écran est large, afficher tout en ligne
                    if (constraints.maxWidth > 600) {
                      return Row(
                        children: [
                          // Filtre État
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Text('État: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
                                  ..._etats.entries.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: FilterChip(
                                        label: Text(e.value, style: const TextStyle(fontSize: 11)),
                                        selected: _filtreEtat == e.key,
                                        onSelected: (_) {
                                          setState(() {
                                            _filtreEtat = _filtreEtat == e.key ? null : e.key;
                                          });
                                          _updateFilters();
                                        },
                                        visualDensity: VisualDensity.compact,
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                        selectedColor: Colors.blue.shade100,
                                        backgroundColor: Colors.white,
                                        labelStyle: TextStyle(
                                          color: _filtreEtat == e.key ? Colors.blue.shade700 : Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Filtre Catégorie
                          Expanded(
                            flex: 2,
                            child: categoriesAsync.when(
                              data: (cats) {
                                final categoriesList = <String, String>{
                                  '': 'Toutes catégories',
                                };
                                for (final cat in cats) {
                                  final id = cat['id_categorie']?.toString() ?? '';
                                  final nom = cat['nom']?.toString() ?? '';
                                  if (id.isNotEmpty) {
                                    categoriesList[id] = nom;
                                  }
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _filtreCategorie,
                                        isDense: true,
                                        hint: const Text(
                                          'Catégorie',
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        ),
                                        items: categoriesList.entries.map((entry) {
                                          return DropdownMenuItem<String>(
                                            value: entry.key,
                                            child: Text(
                                              entry.value,
                                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _filtreCategorie = value;
                                          });
                                          _updateFilters();
                                        },
                                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                                        dropdownColor: Colors.white,
                                        icon: const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black54),
                                        selectedItemBuilder: (context) {
                                          return categoriesList.entries.map((entry) {
                                            return Text(
                                              entry.value,
                                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const SizedBox(
                                height: 36,
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              ),
                              error: (e, _) => Text(
                                'Erreur: $e',
                                style: const TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Écran mobile : empiler verticalement
                      return Column(
                        children: [
                          // Filtre État (horizontal scroll)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Text('État: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
                                ..._etats.entries.map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: FilterChip(
                                      label: Text(e.value, style: const TextStyle(fontSize: 11)),
                                      selected: _filtreEtat == e.key,
                                      onSelected: (_) {
                                        setState(() {
                                          _filtreEtat = _filtreEtat == e.key ? null : e.key;
                                        });
                                        _updateFilters();
                                      },
                                      visualDensity: VisualDensity.compact,
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                      selectedColor: Colors.blue.shade100,
                                      backgroundColor: Colors.white,
                                      labelStyle: TextStyle(
                                        color: _filtreEtat == e.key ? Colors.blue.shade700 : Colors.black87,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Filtre Catégorie
                          categoriesAsync.when(
                            data: (cats) {
                              final categoriesList = <String, String>{
                                '': 'Toutes catégories',
                              };
                              for (final cat in cats) {
                                final id = cat['id_categorie']?.toString() ?? '';
                                final nom = cat['nom']?.toString() ?? '';
                                if (id.isNotEmpty) {
                                  categoriesList[id] = nom;
                                }
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _filtreCategorie,
                                      isDense: true,
                                      hint: const Text(
                                        'Catégorie',
                                        style: TextStyle(fontSize: 12, color: Colors.black54),
                                      ),
                                      items: categoriesList.entries.map((entry) {
                                        return DropdownMenuItem<String>(
                                          value: entry.key,
                                          child: Text(
                                            entry.value,
                                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _filtreCategorie = value;
                                        });
                                        _updateFilters();
                                      },
                                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                                      dropdownColor: Colors.white,
                                      icon: const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black54),
                                      selectedItemBuilder: (context) {
                                        return categoriesList.entries.map((entry) {
                                          return Text(
                                            entry.value,
                                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            loading: () => const SizedBox(
                              height: 36,
                              child: Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ),
                            error: (e, _) => Text(
                              'Erreur: $e',
                              style: const TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              const Divider(height: 1),

              // Indicateur de chargement
              if (materielsAsync.isLoading)
                const LinearProgressIndicator(),

              Expanded(
                child: materielsAsync.when(
                  loading: () => const Center(child: AppLoading()),
                  error: (e, _) => ErrorView(
                    message: e.toString(),
                    onRetry: () {
                      ref.invalidate(materielsProvider);
                    },
                  ),
                  data: (mats) {
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
                      onRefresh: () async {
                        ref.invalidate(materielsProvider);
                        await Future.delayed(const Duration(milliseconds: 100));
                      },
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