import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/demandes_affectations/provider/demandes_affectations_provider.dart';
import 'package:materelia/features/demandes_affectations/provider/other_provider.dart';
import 'package:materelia/shared/models/demande_affectation.dart';
import 'package:materelia/shared/tools/date_convert.dart';
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

class DemandesAffectationsPage extends ConsumerStatefulWidget {
  const DemandesAffectationsPage({super.key});

  @override
  ConsumerState<DemandesAffectationsPage> createState() =>
      _DemandesAffectationsPageState();
}

class _DemandesAffectationsPageState
    extends ConsumerState<DemandesAffectationsPage> {
  String _search = '';
  String? _filtreEtat;
  String? _selectedId;
  bool _showDetail = false;

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
  });

  void _selectItem(String id) => setState(() {
    _selectedId = id;
    _showDetail = true;
  });

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(demandesAffectationsControllerProvider);
    final isLoading = async.isLoading;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      children: [
        // ── Toolbar ──
        Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() => _showDetail = !_showDetail),
          onRefresh: () => ref
              .read(demandesAffectationsControllerProvider.notifier)
              .refresh(),
          creer: null,
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
              onRetry: () => ref
                  .read(demandesAffectationsControllerProvider.notifier)
                  .refresh(),
            ),
            data: (liste) {
              final filtrees = _filtrer(liste);
              final master = _ListeDemandes(
                liste: filtrees,
                selectedId: _selectedId,
                onSelect: _selectItem,
              );

              if (!_showDetail) return master;

              if (isDesktop) {
                return Row(
                  children: [
                    SizedBox(width: 320, child: master),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: DetailPanel(
                        onClose: _closeDetail,
                        type: "demande",
                        child: _selectedId == null
                            ? Center(child: Text('Sélectionnez une demande'))
                            : _DemandeDetailContent(
                                id: _selectedId!,
                                onActionDone: _closeDetail,
                              ),
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
                      child: _selectedId == null
                          ? Center(child: Text('Sélectionnez une demande'))
                          : _DemandeDetailContent(
                              id: _selectedId!,
                              onActionDone: _closeDetail,
                            ),
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
  final _motifCtrl = TextEditingController();
  bool _showRefusForm = false;
  String? _selectedMaterielId;

  @override
  void dispose() {
    _motifCtrl.dispose();
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
        if (demande.dateAction != null)
          InfoRow('Date Validation/Refus', dateConvert(demande.dateAction!)),
        if (demande.motifRefus != null)
          InfoRow('Motif refus', demande.motifRefus!),

        if (enAttente) ...[
          const SizedBox(height: 24),
          const Divider(),
          _ChoisirMaterielSection(
            categorieId: demande.idCategorie,
            selectedId: _selectedMaterielId,
            onSelect: (id) {
              setState(() {
                _selectedMaterielId = id;
              });
            },
          ),

          const SizedBox(height: 12),
          _ActionsEnAttente(
            // ✅ Valider disabled si pas de matériel choisi
            // canValider: _materielChoisi != null,
            showRefusForm: _showRefusForm,
            motifCtrl: _motifCtrl,
            onValider: () => _valider(demande.id),
            onShowRefus: () => setState(() => _showRefusForm = true),
            onAnnulerRefus: () => setState(() {
              _showRefusForm = false;
              _motifCtrl.clear();
            }),
            onConfirmerRefus: () => _refuser(demande.id),
          ),
        ],
      ],
    );
  }

  Future<void> _valider(String idDemande) async {
    if (_selectedMaterielId == null) return;

    await ref
        .read(demandesAffectationsControllerProvider.notifier)
        .validerDemande(idDemande: idDemande, idMateriel: _selectedMaterielId!);

    widget.onActionDone();
  }

  Future<void> _refuser(String idDemande) async {
    if (_motifCtrl.text.trim().isEmpty) return;
    await ref
        .read(demandesAffectationsControllerProvider.notifier)
        .refuserDemande(idDemande: idDemande, motif: _motifCtrl.text.trim());
    widget.onActionDone();
  }
}

// ════════════════════════════════════════════════════════════════
// ACTIONS EN ATTENTE
// ════════════════════════════════════════════════════════════════
class _ActionsEnAttente extends StatelessWidget {
  final bool showRefusForm;
  final TextEditingController motifCtrl;
  final VoidCallback onValider;
  final VoidCallback onShowRefus;
  final VoidCallback onAnnulerRefus;
  final VoidCallback onConfirmerRefus;

  const _ActionsEnAttente({
    required this.showRefusForm,
    required this.motifCtrl,
    required this.onValider,
    required this.onShowRefus,
    required this.onAnnulerRefus,
    required this.onConfirmerRefus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: onValider,
          icon: const Icon(Icons.check),
          label: const Text('Valider'),
        ),
        const SizedBox(height: 8),
        if (!showRefusForm)
          OutlinedButton.icon(
            onPressed: onShowRefus,
            icon: const Icon(Icons.close),
            label: const Text('Refuser'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          )
        else ...[
          TextField(
            controller: motifCtrl,
            decoration: const InputDecoration(
              labelText: 'Motif du refus *',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onAnnulerRefus,
                  child: const Text('Annuler'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: onConfirmerRefus,
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Confirmer refus'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CHOISIR MATÉRIEL
// ════════════════════════════════════════════════════════════════
class _ChoisirMaterielSection extends ConsumerWidget {
  final String categorieId;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _ChoisirMaterielSection({
    required this.categorieId,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMateriels = ref.watch(materielsDisponiblesProvider(categorieId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Matériel à affecter',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        asyncMateriels.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),

          error: (error, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Erreur : $error',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),

          data: (materiels) {
            if (materiels.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Aucun matériel disponible dans cette catégorie.',
                  style: TextStyle(color: Colors.grey),
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
                  itemCount: materiels.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final materiel = materiels[index];
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
                        'SN: ${materiel.reference} · '
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
