import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/constants/app_constants.dart';
import 'package:materelia/features/affectations/provider/affectations_provider.dart';
import 'package:materelia/features/affectations/service/affectations_service.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import 'package:materelia/shared/widgets/detail_panel.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/filtre_chips.dart';
import 'package:materelia/shared/widgets/info_row.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';

// ── Badges ───────────────────────────────────────────────────────
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
class AffectationsPage extends ConsumerStatefulWidget {
  const AffectationsPage({super.key});

  @override
  ConsumerState<AffectationsPage> createState() => _AffectationsPageState();
}

class _AffectationsPageState extends ConsumerState<AffectationsPage> {
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
          item.categorie.nom.toLowerCase().contains(_search.toLowerCase()) ||
          item.beneficiaire.nom.toLowerCase().contains(_search.toLowerCase()) ||
          item.beneficiaire.prenom.toLowerCase().contains(
            _search.toLowerCase(),
          );
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
    final async = ref.watch(affectationsControllerProvider);
    final isLoading = async.isLoading;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      children: [
        Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() => _showDetail = !_showDetail),
          onRefresh: () =>
              ref.read(affectationsControllerProvider.notifier).refresh(),
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

        Expanded(
          child: async.when(
            loading: () => const AppLoading(),
            error: (e, _) => ErrorView(
              message: e.toString(),
              onRetry: () =>
                  ref.read(affectationsControllerProvider.notifier).refresh(),
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
                            "Sélectionnez une affectation pour afficher ses détails.",
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
                    SizedBox(width: 360, child: master),
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

  Color? _tileColor(AffectationListItem item) {
    final fin = item.affectation.dateFinPrevue;
    final diff = fin.difference(DateTime.now()).inDays;
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
          message: "Aucune affectation trouvée.",
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

        return ListTile(
          tileColor: _tileColor(item),
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.beneficiaire.prenom} ${item.beneficiaire.nom}",
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                "Du ${dateConvert(affectation.dateDebut)}  →  ${dateConvert(affectation.dateFinPrevue)}",
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          isThreeLine: true,
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
    final async = ref.watch(affectationDetailAdminProvider(id));

    return async.when(
      loading: () => const AppLoading(),
      error: (e, _) => ErrorView(
        message: e.toString(),
        onRetry: () =>
            ref.read(affectationsControllerProvider.notifier).refresh(),
      ),
      data: (detail) {
        final a = detail.affectation;
        final m = detail.materiel;
        final c = detail.categorie;
        final d = detail.demande;
        final u = detail.beneficiaire;

        final estActive = a.etat == AppConstants.affectationActive;
        final estRevoquee = a.etat == AppConstants.affectationRevoquee;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Bénéficiaire ──────────────────────────────────
            _SectionTitle("Bénéficiaire"),
            InfoRow('Nom', '${u.prenom} ${u.nom}'),
            InfoRow('Rôle', u.role),

            const SizedBox(height: 16),

            // ── Catégorie ─────────────────────────────────────
            _SectionTitle("Catégorie de matériel"),
            InfoRow('Nom', c.nom),
            if (c.description != null) InfoRow('Description', c.description!),

            const SizedBox(height: 16),

            // ── Matériel ──────────────────────────────────────
            _SectionTitle("Matériel affecté"),
            InfoRow('Nom', m.nom),
            InfoRow('Référence', m.reference),
            if (m.description != null) InfoRow('Description', m.description!),

            const SizedBox(height: 16),

            // ── Demande ───────────────────────────────────────
            _SectionTitle("Demande"),
            InfoRow('Service', d.serviceBeneficiaire),
            InfoRow('Justification', d.justification),
            if (d.dateDemande != null)
              InfoRow('Date demande', dateConvert(d.dateDemande!)),

            const SizedBox(height: 16),

            // ── Affectation ───────────────────────────────────
            _SectionTitle("Affectation"),
            InfoRow('État', a.etat),
            InfoRow('Date début', dateConvert(a.dateDebut)),
            InfoRow('Date fin prévue', dateConvert(a.dateFinPrevue)),
            if (a.dateFinEffective != null)
              InfoRow('Date fin effective', dateConvert(a.dateFinEffective!)),

            const SizedBox(height: 24),

            // ── Actions ───────────────────────────────────────
            if (estActive) ...[
              _ActionButton(
                label: 'Renouveler',
                icon: Icons.autorenew,
                color: Colors.blue,
                onTap: () =>
                    _confirmerRenouveler(context, ref, a.id, a.dateFinPrevue),
              ),
              const SizedBox(height: 10),
            ],

            if (!estRevoquee)
              _ActionButton(
                label: 'Révoquer',
                icon: Icons.block,
                color: Colors.red,
                onTap: () => _confirmerRevoquer(context, ref, a.id),
              ),
          ],
        );
      },
    );
  }

  // ── Dialogues de confirmation ──────────────────────────────────

  Future<void> _confirmerRevoquer(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Révoquer l\'affectation'),
        content: const Text(
          'Cette action est définitive. L\'affectation sera clôturée immédiatement.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Révoquer'),
          ),
        ],
      ),
    );

    if (ok == true && context.mounted) {
      await ref.read(affectationsControllerProvider.notifier).revoquer(id);
      onActionDone();
    }
  }

  Future<void> _confirmerRenouveler(
    BuildContext context,
    WidgetRef ref,
    String id,
    DateTime dateFinActuelle,
  ) async {
    final nouvelleFin = dateFinActuelle.add(
      Duration(days: AppConstants.dureeAffectationJours),
    );

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Renouveler l\'affectation'),
        content: Text(
          'La date de fin sera repoussée au ${dateConvert(nouvelleFin)}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );

    if (ok == true && context.mounted) {
      await ref
          .read(affectationsControllerProvider.notifier)
          .renouveler(id, dateFinActuelle);
      onActionDone();
    }
  }
}

// ════════════════════════════════════════════════════════════════
// WIDGETS UTILITAIRES
// ════════════════════════════════════════════════════════════════
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

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: color),
        label: Text(label, style: TextStyle(color: color)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
      ),
    );
  }
}
