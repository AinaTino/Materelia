import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/mes_demandes/provider/mes_demandes_provider.dart';
import 'package:materelia/features/mes_demandes/provider/other_provider.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import 'package:materelia/shared/widgets/detail_panel.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/filtre_chips.dart';
import 'package:materelia/shared/widgets/info_row.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';

class EtatBadge {
  final BadgeEtatType type;
  final String label;

  const EtatBadge(this.type, this.label);
}

const etats = {
  "EN_ATTENTE": EtatBadge(BadgeEtatType.warning, "En attente"),
  'VALIDE': EtatBadge(BadgeEtatType.success, 'Validée'),
  'REFUSE': EtatBadge(BadgeEtatType.error, "Refusée"),
};

class MesDemandesPage extends ConsumerStatefulWidget {
  const MesDemandesPage({super.key});

  @override
  ConsumerState<MesDemandesPage> createState() => _MesDemandesPageState();
}

class _MesDemandesPageState extends ConsumerState<MesDemandesPage> {
  String _search = '';
  String? _filtreEtat;
  String? _selectedId;
  bool _showDetail = false;
  bool _showCreate = false;

  List<DemandeAffectation> _filtrer(List<DemandeAffectation> all) {
    return all.where((d) {
      final matchEtat = _filtreEtat == null || d.etat == _filtreEtat;
      final matchSearch =
          _search.isEmpty ||
          d.justification.toLowerCase().contains(_search.toLowerCase()) ||
          d.serviceBeneficiaire.toLowerCase().contains(_search.toLowerCase());
      return matchEtat && matchSearch;
    }).toList();
  }

  void _closeDetail() => setState(() {
    _showDetail = false;
    _selectedId = null;
    _showCreate = false;
  });

  void _openCreate() => setState(() {
    _selectedId = null;
    _showDetail = true;
    _showCreate = true;
  });

  void _selectItem(String id) => setState(() {
    _selectedId = id;
    _showDetail = true;
    _showCreate = false;
  });

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mesDemandesControllerProvider);
    final isLoading = async.isLoading;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      children: [
        // ── Toolbar ──
        Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() {
            _showDetail = !_showDetail;
            if (!_showDetail) _showCreate = false;
          }),
          onRefresh: () =>
              ref.read(mesDemandesControllerProvider.notifier).refresh(),
          creer: _openCreate,
        ),
        const Divider(height: 1),

        FiltreChips(
          filtreActif: _filtreEtat,
          etats: const {
            'EN_ATTENTE': 'En attente',
            'VALIDE': 'Validée',
            'REFUSE': 'Refusée',
          },
          onFiltreChange: (etat) => setState(() => _filtreEtat = etat),
        ),
        const Divider(height: 1),

        SizedBox(
          height: 2,
          child: isLoading
              ? const LinearProgressIndicator()
              : const SizedBox.shrink(),
        ),

        // ── Corps ──
        Expanded(
          child: async.when(
            loading: () => const AppLoading(),
            error: (e, _) => ErrorView(
              message: e.toString(),
              onRetry: () =>
                  ref.read(mesDemandesControllerProvider.notifier).refresh(),
            ),
            data: (liste) {
              final filtrees = _filtrer(liste);
              final master = _ListeDemandes(
                liste: filtrees,
                selectedId: _selectedId,
                onSelect: _selectItem,
              );

              if (!_showDetail) return master;

              final panelChild = _showCreate
                  ? _CreerDemandeContent(
                      onCreated: () {
                        setState(() {
                          _showDetail = false;
                          _showCreate = false;
                          _selectedId = null;
                        });
                      },
                      onCancel: _closeDetail,
                    )
                  : _selectedId == null
                  ? Center(
                      child: FeedbackCard(
                        type: FeedbackType.info,
                        message:
                            "Sélectionnez une demande dans la liste pour afficher ses informations.",
                        dense: true,
                      ),
                    )
                  : _DemandeDetailContent(
                      id: _selectedId!,
                      onActionDone: _closeDetail,
                    );

              if (isDesktop) {
                return Row(
                  children: [
                    SizedBox(width: 320, child: master),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: DetailPanel(
                        onClose: _closeDetail,
                        type: "demande",
                        child: panelChild,
                      ),
                    ),
                  ],
                );
              }

              return Stack(
                children: [
                  master,
                  Positioned.fill(
                    child: DetailPanel(
                      onClose: _closeDetail,
                      type: "demande",
                      child: panelChild,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// CRÉER UNE DEMANDE
// ════════════════════════════════════════════════════════════════
class _CreerDemandeContent extends ConsumerStatefulWidget {
  final VoidCallback onCreated;
  final VoidCallback onCancel;

  const _CreerDemandeContent({required this.onCreated, required this.onCancel});

  @override
  ConsumerState<_CreerDemandeContent> createState() =>
      _CreerDemandeContentState();
}

class _CreerDemandeContentState extends ConsumerState<_CreerDemandeContent> {
  final _formKey = GlobalKey<FormState>();
  final _serviceCtrl = TextEditingController();
  final _justificationCtrl = TextEditingController();
  String? _selectedCategorieId;
  String? _categoryError;
  bool _submitting = false;

  @override
  void dispose() {
    _serviceCtrl.dispose();
    _justificationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Nouvelle demande',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _serviceCtrl,
                decoration: const InputDecoration(
                  labelText: 'Service bénéficiaire *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Le service est obligatoire.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _justificationCtrl,
                decoration: const InputDecoration(
                  labelText: 'Justification *',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La justification est obligatoire.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _ChoisirCategorieSection(
                title: 'Catégorie *',
                selectedId: _selectedCategorieId,
                onSelect: (id) {
                  setState(() {
                    _selectedCategorieId = id;
                    _categoryError = null;
                  });
                },
              ),
              if (_categoryError != null) ...[
                const SizedBox(height: 8),
                Text(
                  _categoryError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _submitting ? null : _createDemande,
                      child: _submitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Créer la demande'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _submitting ? null : widget.onCancel,
                      child: const Text('Annuler'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _createDemande() async {
    if (_submitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategorieId == null) {
      setState(() {
        _categoryError = 'La catégorie est obligatoire.';
      });
      return;
    }

    setState(() {
      _submitting = true;
    });

    try {
      await ref
          .read(mesDemandesControllerProvider.notifier)
          .creerDemande(
            justification: _justificationCtrl.text.trim(),
            serviceBeneficiaire: _serviceCtrl.text.trim(),
            idCategorie: _selectedCategorieId!,
          );

      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: 'Demande créée avec succès.',
        type: FeedbackType.success,
      );
      widget.onCreated();
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: 'Erreur lors de la création de la demande. $e',
        type: FeedbackType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }
}

// ════════════════════════════════════════════════════════════════
// LISTE
// ════════════════════════════════════════════════════════════════
class _ListeDemandes extends StatelessWidget {
  final List<DemandeAffectation> liste;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _ListeDemandes({
    required this.liste,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (liste.isEmpty) {
      return const Center(
        child: FeedbackCard(
          icon: Icons.inbox_outlined,
          type: FeedbackType.warning,
          title: "Aucune demande",
          message: "Les demandes apparaîtront ici dès leur création.",
        ),
      );
    }

    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (_, i) {
        final demande = liste[i];
        final isSelected = demande.id == selectedId;
        final badge = etats[demande.etat]!;

        return ListTile(
          leading: Icon(
            isSelected ? Icons.chevron_right : Icons.circle_outlined,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            size: 20,
          ),
          title: Text(demande.serviceBeneficiaire),
          subtitle: Text(
            "${demande.justification}  /  Date de la demande : ${dateConvert(demande.createdAt!)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: BadgeEtat(etat: badge.type, label: badge.label),
          selected: isSelected,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          onTap: () => onSelect(demande.id),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CONTENU DÉTAIL
// ════════════════════════════════════════════════════════════════
class _DemandeDetailContent extends ConsumerStatefulWidget {
  final String id;
  final VoidCallback onActionDone;

  const _DemandeDetailContent({required this.id, required this.onActionDone});

  @override
  ConsumerState<_DemandeDetailContent> createState() =>
      _DemandeDetailContentState();
}

class _DemandeDetailContentState extends ConsumerState<_DemandeDetailContent> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final demande = ref.watch(demandeByIdProvider(widget.id));

    if (demande == null) return const AppLoading();

    final enAttente = demande.etat == 'EN_ATTENTE';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        InfoRow('Service', demande.serviceBeneficiaire),
        InfoRow('Justification', demande.justification),
        InfoRow('État', demande.etat),
        InfoRow("Date de la demande", dateConvert(demande.dateDemande!)),
        if (demande.dateAction != null)
          InfoRow('Date Validation/Refus', dateConvert(demande.dateAction!)),
        if (demande.motifRefus != null)
          InfoRow('Motif refus', demande.motifRefus!),

        if (enAttente) ...[
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _supprimer(demande.id),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Annuler la demande'),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ],
    );
  }

  Future<void> _supprimer(String idDemande) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Annuler la demande'),
          content: const Text(
            'Voulez-vous vraiment annuler cette demande ? Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );

    if (confirmation != true) return;

    try {
      await ref
          .read(mesDemandesControllerProvider.notifier)
          .supprimerDemande(idDemande: idDemande);

      if (!mounted) return;
      widget.onActionDone();
      AppSnackBar.show(
        context,
        message: 'Demande annulée avec succès.',
        type: FeedbackType.success,
      );
    } catch (_) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: "Erreur lors de l'annulation de la demande.",
        type: FeedbackType.error,
      );
    }
  }
}

// ════════════════════════════════════════════════════════════════
// CHOISIR Categorie
// ════════════════════════════════════════════════════════════════
class _ChoisirCategorieSection extends ConsumerWidget {
  final String title;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _ChoisirCategorieSection({
    required this.title,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesDisponiblesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        asyncCategories.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),

          error: (error, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FeedbackCard(
              type: FeedbackType.error,
              message: 'Erreur : $error',
            ),
          ),

          data: (categories) {
            if (categories.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: FeedbackCard(
                  type: FeedbackType.warning,
                  message: 'Aucun matériel disponible.',
                ),
              );
            }

            return RadioGroup<String>(
              groupValue: selectedId,
              onChanged: (value) {
                if (value != null) {
                  onSelect(value);
                }
              },
              child: SizedBox(
                height: 240,
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final materiel = categories[index];
                    final isSelected = materiel.id == selectedId;

                    return RadioListTile<String>(
                      value: materiel.id,
                      selected: isSelected,
                      selectedTileColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      title: Text(
                        materiel.nom,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Description: ${materiel.description ?? "-"}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      secondary: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
