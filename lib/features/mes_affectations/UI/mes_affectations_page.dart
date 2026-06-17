import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/mes_affectations/provider/mes_affectations_provider.dart';
import 'package:materelia/features/mes_affectations/service/mes_affectations_service.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import 'package:materelia/shared/widgets/detail_panel.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/filtre_chips.dart';
import 'package:materelia/shared/widgets/info_row.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/toolbar.dart';

// ── Badges état ──────────────────────────────────────────────────
class EtatBadge {
  final BadgeEtatType type;
  final String label;
  const EtatBadge(this.type, this.label);
}

const etats = {
  AppConstants.affectationRevoquee: EtatBadge(
    BadgeEtatType.warning,
    "Révoquée",
  ),
  AppConstants.affectationActive: EtatBadge(BadgeEtatType.success, "Active"),
  AppConstants.affectationExpiree: EtatBadge(BadgeEtatType.error, "Expirée"),
};

// ════════════════════════════════════════════════════════════════
// PAGE
// ════════════════════════════════════════════════════════════════
class MesAffectationsPage extends ConsumerStatefulWidget {
  const MesAffectationsPage({super.key});

  @override
  ConsumerState<MesAffectationsPage> createState() =>
      _MesAffectationsPageState();
}

class _MesAffectationsPageState extends ConsumerState<MesAffectationsPage> {
  String _search = '';
  String? _filtreEtat;
  String? _selectedId;
  bool _showDetail = false;

  List<AffectationListItem> _filtrer(List<AffectationListItem> all) {
    return all.where((item) {
      final matchEtat =
          _filtreEtat == null || item.affectation.etat == _filtreEtat;
      final matchSearch =
          _search.isEmpty ||
          item.categorie.nom.toLowerCase().contains(_search.toLowerCase());
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
    final async = ref.watch(mesAffectationsControllerProvider);
    final isLoading = async.isLoading;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      children: [
        // ── Toolbar ──
        Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() => _showDetail = !_showDetail),
          onRefresh: () =>
              ref.read(mesAffectationsControllerProvider.notifier).refresh(),
          creer: null,
        ),
        const Divider(height: 1),

        FiltreChips(
          filtreActif: _filtreEtat,
          etats: const {
            AppConstants.affectationActive: 'Active',
            AppConstants.affectationExpiree: 'Expirée',
            AppConstants.affectationRevoquee: 'Révoquée',
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
                  .read(mesAffectationsControllerProvider.notifier)
                  .refresh(),
            ),
            data: (liste) {
              final filtrees = _filtrer(liste);

              final master = _ListeAffectations(
                liste: filtrees,
                selectedId: _selectedId,
                onSelect: _selectItem,
              );

              if (!_showDetail) return master;

              final panelChild = _selectedId == null
                  ? Center(
                      child: FeedbackCard(
                        type: FeedbackType.info,
                        message:
                            "Sélectionnez une affectation pour afficher ses informations.",
                        dense: true,
                      ),
                    )
                  : _AffectationDetailContent(
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
                        type: "affectation",
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
                      type: "affectation",
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

// ════════════════════════════════════════════════════════════════
// LISTE
// ════════════════════════════════════════════════════════════════
class _ListeAffectations extends StatelessWidget {
  final List<AffectationListItem> liste;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _ListeAffectations({
    required this.liste,
    required this.selectedId,
    required this.onSelect,
  });

  /// Fond légèrement rouge si la date de fin est dans moins de 7 jours
  /// et que l'affectation est encore active.
  Color? _tileColor(AffectationListItem item, BuildContext context) {
    final fin = item.affectation.dateFinPrevue;
    final maintenant = DateTime.now();
    final diff = fin.difference(maintenant).inDays;
    final active = item.affectation.etat == AppConstants.affectationActive;

    if (active && diff >= 0 && diff < 7) {
      return Colors.red.withValues(alpha: 0.08);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (liste.isEmpty) {
      return const Center(
        child: FeedbackCard(
          icon: Icons.inbox_outlined,
          type: FeedbackType.warning,
          title: "Aucune affectation",
          message: "Vos affectations apparaîtront ici.",
        ),
      );
    }

    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (_, i) {
        final item = liste[i];
        final affectation = item.affectation;
        final isSelected = affectation.id == selectedId;
        final badge = etats[affectation.etat]!;
        final bgColor = _tileColor(item, context);

        return ListTile(
          tileColor: bgColor,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          selected: isSelected,
          leading: Icon(
            isSelected ? Icons.chevron_right : Icons.circle_outlined,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            size: 20,
          ),
          title: Text(
            item.categorie.nom,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Du ${dateConvert(affectation.dateDebut)}  →  ${dateConvert(affectation.dateFinPrevue)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: BadgeEtat(etat: badge.type, label: badge.label),
          onTap: () => onSelect(affectation.id),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// DÉTAIL
// ════════════════════════════════════════════════════════════════
class _AffectationDetailContent extends ConsumerWidget {
  final String id;
  final VoidCallback onActionDone;

  const _AffectationDetailContent({
    required this.id,
    required this.onActionDone,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(affectationDetailProvider(id));

    return async.when(
      loading: () => const AppLoading(),
      error: (e, _) => FeedbackCard(
        type: FeedbackType.error,
        message:
            "Erreur de chargement des informations, veuillez recharger la page.",
      ),
      data: (detail) {
        final a = detail.affectation;
        final m = detail.materiel;
        final c = detail.categorie;
        final d = detail.demande;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Catégorie ──
            _SectionTitle("Catégorie de matériel"),
            InfoRow('Nom', c.nom),
            if (c.description != null) InfoRow('Description', c.description!),

            const SizedBox(height: 12),

            // ── Matériel ──
            _SectionTitle("Matériel affecté"),
            InfoRow('Référence', m.reference),

            // Ajoute ici les champs de Materiel que tu veux afficher
            const SizedBox(height: 12),

            // ── Demande ──
            _SectionTitle("Demande d'affectation"),
            InfoRow('Service', d.serviceBeneficiaire),
            InfoRow('Justification', d.justification),
            if (d.dateDemande != null)
              InfoRow('Date demande', dateConvert(d.dateDemande!)),
            if (d.motifRefus != null) InfoRow('Motif refus', d.motifRefus!),

            const SizedBox(height: 12),

            // ── Affectation ──
            _SectionTitle("Affectation"),
            InfoRow('État', a.etat),
            InfoRow('Date début', dateConvert(a.dateDebut)),
            InfoRow('Date fin prévue', dateConvert(a.dateFinPrevue)),
            if (a.dateFinEffective != null)
              InfoRow('Date fin effective', dateConvert(a.dateFinEffective!)),
          ],
        );
      },
    );
  }
}

// Petit widget titre de section
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
