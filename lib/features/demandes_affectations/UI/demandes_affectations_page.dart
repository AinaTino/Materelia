import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/demandes_affectations/provider/demandes_affectations_provider.dart';
import 'package:materelia/shared/models/demande_affectation.dart';

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
      final matchSearch = _search.isEmpty ||
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
        _Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() => _showDetail = !_showDetail),
          onRefresh: () => ref
              .read(demandesAffectationsControllerProvider.notifier)
              .refresh(),
        ),
        const Divider(height: 1),

        // ── Filtres ──
        _FiltreChips(
          filtreActif: _filtreEtat,
          etats: const {
            'EN_ATTENTE': 'En attente',
            'VALIDE': 'Validée',
            'REFUSE': 'Refusée',
          },
          onFiltreChange: (etat) => setState(() => _filtreEtat = etat),
        ),
        const Divider(height: 1),

        // ── Linear progress ──
        SizedBox(
          height: 2,
          child: isLoading
              ? const LinearProgressIndicator()
              : const SizedBox.shrink(),
        ),

        // ── Corps ──
        Expanded(
          child: async.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => _ErrorView(
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
                      child: _DetailPanel(
                        selectedId: _selectedId,
                        onClose: _closeDetail,
                        onActionDone: _closeDetail,
                      ),
                    ),
                  ],
                );
              }

              return Stack(
                children: [
                  master,
                  Positioned.fill(
                    child: _DetailPanel(
                      selectedId: _selectedId,
                      onClose: _closeDetail,
                      onActionDone: _closeDetail,
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
// TOOLBAR
// ════════════════════════════════════════════════════════════════

class _Toolbar extends StatelessWidget {
  final bool showDetail;
  final ValueChanged<String> onSearch;
  final VoidCallback onToggleDetail;
  final VoidCallback onRefresh;

  const _Toolbar({
    required this.showDetail,
    required this.onSearch,
    required this.onToggleDetail,
    required this.onRefresh,
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

// ════════════════════════════════════════════════════════════════
// CHIPS FILTRE — réutilisable pour n'importe quelle feature
// ════════════════════════════════════════════════════════════════

class _FiltreChips extends StatelessWidget {
  final String? filtreActif;
  final Map<String, String> etats; // { 'EN_ATTENTE': 'En attente', ... }
  final ValueChanged<String?> onFiltreChange; // null = tous

  const _FiltreChips({
    required this.filtreActif,
    required this.etats,
    required this.onFiltreChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Toutes'),
            selected: filtreActif == null,
            onSelected: (_) => onFiltreChange(null),
          ),
          const SizedBox(width: 6),
          ...etats.entries.map((e) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FilterChip(
                  label: Text(e.value),
                  selected: filtreActif == e.key,
                  onSelected: (_) => onFiltreChange(
                    filtreActif == e.key ? null : e.key,
                  ),
                ),
              )),
        ],
      ),
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
      return const Center(child: Text('Aucune demande'));
    }

    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (_, i) {
        final demande = liste[i];
        final isSelected = demande.id == selectedId;

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
            demande.justification,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: _BadgeEtat(etat: demande.etat),
          selected: isSelected,
          selectedTileColor: Theme.of(context)
              .colorScheme
              .primaryContainer
              .withOpacity(0.3),
          onTap: () => onSelect(demande.id),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PANNEAU DROIT
// ════════════════════════════════════════════════════════════════

class _DetailPanel extends StatelessWidget {
  final String? selectedId;
  final VoidCallback onClose;
  final VoidCallback onActionDone;

  const _DetailPanel({
    required this.selectedId,
    required this.onClose,
    required this.onActionDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
                const Text(
                  'Détail demande',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Contenu
          Expanded(
            child: selectedId == null
                ? const Center(child: Text('Sélectionnez une demande'))
                : _DemandeDetailContent(
                    id: selectedId!,
                    onActionDone: onActionDone,
                  ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CONTENU DÉTAIL
// ════════════════════════════════════════════════════════════════

class _DemandeDetailContent extends ConsumerStatefulWidget {
  final String id;
  final VoidCallback onActionDone;

  const _DemandeDetailContent({
    required this.id,
    required this.onActionDone,
  });

  @override
  ConsumerState<_DemandeDetailContent> createState() =>
      _DemandeDetailContentState();
}

class _DemandeDetailContentState
    extends ConsumerState<_DemandeDetailContent> {
  final _motifCtrl = TextEditingController();
  bool _showRefusForm = false;

  @override
  void dispose() {
    _motifCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final liste =
        ref.watch(demandesAffectationsControllerProvider).value;
    final demande = liste?.firstWhere((d) => d.id == widget.id);

    if (demande == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final enAttente = demande.etat == 'EN_ATTENTE';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _InfoRow('Service', demande.serviceBeneficiaire),
        _InfoRow('Justification', demande.justification),
        _InfoRow('État', demande.etat),
        if (demande.dateDebut != null)
          _InfoRow('Date début', _fmt(demande.dateDebut!)),
        if (demande.dateFinPrevue != null)
          _InfoRow('Date fin prévue', _fmt(demande.dateFinPrevue!)),
        if (demande.motifRefus != null)
          _InfoRow('Motif refus', demande.motifRefus!),

        if (enAttente) ...[
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          _ActionsEnAttente(
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
    await ref
        .read(demandesAffectationsControllerProvider.notifier)
        .validerDemande(idDemande: idDemande, idMateriel: 'TODO');
    widget.onActionDone();
  }

  Future<void> _refuser(String idDemande) async {
    if (_motifCtrl.text.trim().isEmpty) return;
    await ref
        .read(demandesAffectationsControllerProvider.notifier)
        .refuserDemande(
          idDemande: idDemande,
          motif: _motifCtrl.text.trim(),
        );
    widget.onActionDone();
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';
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
                  style:
                      FilledButton.styleFrom(backgroundColor: Colors.red),
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
// UTILITAIRES — à déplacer dans shared/widgets/
// ════════════════════════════════════════════════════════════════

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _BadgeEtat extends StatelessWidget {
  final String etat;
  const _BadgeEtat({required this.etat});

  static const _colors = {
    'EN_ATTENTE': (text: Color(0xFFE65100), bg: Color(0xFFFFF3E0)),
    'VALIDE': (text: Color(0xFF2E7D32), bg: Color(0xFFE8F5E9)),
    'REFUSE': (text: Color(0xFFC62828), bg: Color(0xFFFFEBEE)),
  };

  static const _labels = {
    'EN_ATTENTE': 'En attente',
    'VALIDE': 'Validée',
    'REFUSE': 'Refusée',
  };

  @override
  Widget build(BuildContext context) {
    final style =
        _colors[etat] ?? (text: Colors.grey, bg: Color(0xFFF5F5F5));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _labels[etat] ?? etat,
        style: TextStyle(
          color: style.text,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}