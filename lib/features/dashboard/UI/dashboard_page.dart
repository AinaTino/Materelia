import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
import 'package:materelia/features/dashboard/provider/dashboard_provider.dart';
import 'package:materelia/features/dashboard/service/dashboard_service.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dashboardControllerProvider);

    return async.when(
      loading: () => const AppLoading(),
      error: (e, _) => ErrorView(
        message: e.toString(),
        onRetry: () => ref.read(dashboardControllerProvider.notifier).refresh(),
      ),
      data: (stats) => _DashboardContent(stats: stats),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardStats stats;

  const _DashboardContent({required this.stats});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: () => ProviderScope.containerOf(
        context,
      ).read(dashboardControllerProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 32 : 16,
          vertical: 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── En-tête ───────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tableau de bord',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Vue globale du système',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, _) => IconButton.filledTonal(
                        onPressed: () => ref
                            .read(dashboardControllerProvider.notifier)
                            .refresh(),
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Actualiser',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Alertes ───────────────────────────────────
                if (stats.demandesEnAttente > 0 || stats.ticketsEnAttente > 0)
                  _AlertesSection(stats: stats),

                if (stats.demandesEnAttente > 0 || stats.ticketsEnAttente > 0)
                  const SizedBox(height: 24),

                // ── Matériels ─────────────────────────────────
                _SectionTitle(
                  icon: Icons.devices_outlined,
                  title: 'Matériels',
                  total: '${stats.totalMateriels} au total',
                ),
                const SizedBox(height: 12),
                _StatGrid(
                  isDesktop: isDesktop,
                  columns: isDesktop ? 5 : 2,
                  cards: [
                    _StatCard(
                      label: 'En stock',
                      value: stats.materielsEnStock,
                      icon: Icons.inventory_2_outlined,
                      color: Colors.green,
                    ),
                    _StatCard(
                      label: 'Affectés',
                      value: stats.materielsAffectes,
                      icon: Icons.assignment_ind_outlined,
                      color: Colors.blue,
                    ),
                    _StatCard(
                      label: 'Empruntés',
                      value: stats.materielsEmpruntes,
                      icon: Icons.swap_horiz,
                      color: Colors.orange,
                    ),
                    _StatCard(
                      label: 'En panne',
                      value: stats.materielsEnPanne,
                      icon: Icons.build_outlined,
                      color: Colors.red,
                    ),
                    _StatCard(
                      label: 'Réformés',
                      value: stats.materielsReformes,
                      icon: Icons.delete_outline,
                      color: Colors.grey,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Activité ──────────────────────────────────
                _SectionTitle(
                  icon: Icons.timeline_outlined,
                  title: 'Activité en cours',
                ),
                const SizedBox(height: 12),
                _StatGrid(
                  isDesktop: isDesktop,
                  columns: isDesktop ? 4 : 2,
                  cards: [
                    _StatCard(
                      label: 'Demandes en attente',
                      value: stats.demandesEnAttente,
                      icon: Icons.pending_outlined,
                      color: Colors.orange,
                      highlight: stats.demandesEnAttente > 0,
                    ),
                    _StatCard(
                      label: 'Affectations actives',
                      value: stats.affectationsActives,
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    _StatCard(
                      label: 'Tickets en attente',
                      value: stats.ticketsEnAttente,
                      icon: Icons.confirmation_number_outlined,
                      color: AppColors.secondary,
                      contentColor: AppColors.onSecondaryContainer,
                      highlight: stats.ticketsEnAttente > 0,
                    ),
                    _StatCard(
                      label: 'Tickets en cours',
                      value: stats.ticketsEnCours,
                      icon: Icons.hourglass_top_outlined,
                      color: Colors.blue,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Utilisateurs & Infrastructure ─────────────
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _UtilisateursCard(stats: stats)),
                      const SizedBox(width: 16),
                      Expanded(child: _InfraCard(stats: stats)),
                    ],
                  )
                else ...[
                  _UtilisateursCard(stats: stats),
                  const SizedBox(height: 16),
                  _InfraCard(stats: stats),
                ],

                const SizedBox(height: 28),

                // ── Répartition matériels (barre visuelle) ────
                _RepartitionCard(stats: stats),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ALERTES
// ════════════════════════════════════════════════════════════════
class _AlertesSection extends StatelessWidget {
  final DashboardStats stats;

  const _AlertesSection({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (stats.demandesEnAttente > 0)
          FeedbackCard(
            type: FeedbackType.warning,
            icon: Icons.pending_outlined,
            title: 'Demandes en attente',
            message:
                '${stats.demandesEnAttente} demande(s) d\'affectation nécessitent votre attention.',
            dense: true,
          ),
        if (stats.demandesEnAttente > 0 && stats.ticketsEnAttente > 0)
          const SizedBox(height: 8),
        if (stats.ticketsEnAttente > 0)
          FeedbackCard(
            type: FeedbackType.warning,
            icon: Icons.confirmation_number_outlined,
            title: 'Tickets en attente',
            message:
                '${stats.ticketsEnAttente} ticket(s) n\'ont pas encore été traités.',
            dense: true,
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.onSecondaryContainer,
            messageColor: AppColors.onSecondaryContainer,
          ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TITRE DE SECTION
// ════════════════════════════════════════════════════════════════
class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? total;

  const _SectionTitle({required this.icon, required this.title, this.total});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        if (total != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              total!,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GRILLE DE STATS
// ════════════════════════════════════════════════════════════════
class _StatGrid extends StatelessWidget {
  final List<_StatCard> cards;
  final bool isDesktop;
  final int columns;

  const _StatGrid({
    required this.cards,
    required this.isDesktop,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isDesktop ? 1.6 : 1.3,
      children: cards,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CARTE STAT
// ════════════════════════════════════════════════════════════════
class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;
  final Color? contentColor;
  final bool highlight;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.contentColor,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final effectiveContentColor = contentColor ?? color;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: highlight
              ? color.withValues(alpha: 0.5)
              : colorScheme.outlineVariant,
          width: highlight ? 1.5 : 1,
        ),
      ),
      color: highlight ? color.withValues(alpha: 0.05) : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$value',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: highlight ? effectiveContentColor : null,
                  ),
                ),
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: highlight && contentColor != null
                        ? contentColor
                        : colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CARD UTILISATEURS
// ════════════════════════════════════════════════════════════════
class _UtilisateursCard extends StatelessWidget {
  final DashboardStats stats;

  const _UtilisateursCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final total =
        stats.totalUtilisateurs + stats.totalTechniciens + stats.totalAdmins;

    return _InfoCard(
      icon: Icons.people_outline,
      title: 'Utilisateurs',
      subtitle: '$total au total',
      rows: [
        _InfoRow(
          color: Colors.blue,
          label: 'Simples',
          value: stats.totalUtilisateurs,
          total: total,
        ),
        _InfoRow(
          color: Colors.orange,
          label: 'Techniciens',
          value: stats.totalTechniciens,
          total: total,
        ),
        _InfoRow(
          color: Colors.green,
          label: 'Admins',
          value: stats.totalAdmins,
          total: total,
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CARD INFRASTRUCTURE
// ════════════════════════════════════════════════════════════════
class _InfraCard extends StatelessWidget {
  final DashboardStats stats;

  const _InfraCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      icon: Icons.warehouse_outlined,
      title: 'Infrastructure',
      rows: [
        _InfoRow(
          color: Colors.indigo,
          label: 'Zones',
          value: stats.totalZones,
          total: null,
        ),
        _InfoRow(
          color: Colors.teal,
          label: 'Catégories',
          value: stats.totalCategories,
          total: null,
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// INFO CARD (utilisateurs / infra)
// ════════════════════════════════════════════════════════════════
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final List<_InfoRow> rows;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.rows,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const Spacer(),
                  Text(
                    subtitle!,
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            ...rows.map(
              (r) =>
                  Padding(padding: const EdgeInsets.only(bottom: 12), child: r),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final Color color;
  final String label;
  final int value;
  final int? total;

  const _InfoRow({
    required this.color,
    required this.label,
    required this.value,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final pct = total != null && total! > 0 ? value / total! : 0.0;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: textTheme.bodySmall)),
            Text(
              '$value',
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        if (total != null) ...[
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: colorScheme.surfaceContainerHighest,
              color: color,
              minHeight: 5,
            ),
          ),
        ],
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// RÉPARTITION MATÉRIELS
// ════════════════════════════════════════════════════════════════
class _RepartitionCard extends StatelessWidget {
  final DashboardStats stats;

  const _RepartitionCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final total = stats.totalMateriels;

    final segments = [
      (label: 'En stock', value: stats.materielsEnStock, color: Colors.green),
      (label: 'Affectés', value: stats.materielsAffectes, color: Colors.blue),
      (
        label: 'Empruntés',
        value: stats.materielsEmpruntes,
        color: Colors.orange,
      ),
      (label: 'En panne', value: stats.materielsEnPanne, color: Colors.red),
      (label: 'Réformés', value: stats.materielsReformes, color: Colors.grey),
    ].where((s) => s.value > 0).toList();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.pie_chart_outline,
                  size: 18,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Répartition des matériels',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (total == 0)
              const FeedbackCard(
                type: FeedbackType.info,
                message: 'Aucun matériel enregistré.',
                dense: true,
              )
            else ...[
              // Barre empilée
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    children: segments.map((s) {
                      return Flexible(
                        flex: s.value,
                        child: Container(color: s.color),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Légende
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: segments.map((s) {
                  final pct = (s.value / total * 100).toStringAsFixed(1);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: s.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${s.label} · ${s.value} ($pct%)',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
