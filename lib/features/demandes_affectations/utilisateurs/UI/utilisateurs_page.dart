import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/demandes_affectations/utilisateurs/provider/other_provider.dart';
import 'package:materelia/features/demandes_affectations/utilisateurs/provider/utilisateurs_provider.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import 'package:materelia/shared/widgets/detail_panel.dart';
import 'package:materelia/shared/widgets/error_view.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/info_row.dart';
import 'package:materelia/shared/widgets/loading.dart';
import 'package:materelia/shared/widgets/toolbar.dart';

// ── Badges rôles ──────────────────────────────────────────────
class RoleBadge {
  final BadgeEtatType type;
  final String label;
  const RoleBadge(this.type, this.label);
}

const roles = {
  'SIMPLE': RoleBadge(BadgeEtatType.secondary, 'Simple'),
  "TECHNICIEN": RoleBadge(BadgeEtatType.warning, 'Technicien'),
  'ADMIN': RoleBadge(BadgeEtatType.success, 'Admin'),
};

// ── Page principale ───────────────────────────────────────────
class UtilisateursPage extends ConsumerStatefulWidget {
  const UtilisateursPage({super.key});

  @override
  ConsumerState<UtilisateursPage> createState() => _UtilisateursPageState();
}

class _UtilisateursPageState extends ConsumerState<UtilisateursPage> {
  String _search = '';
  String? _filtreRole;
  String? _selectedId;
  bool _showDetail = false;

  List<Utilisateur> _filtrer(List<Utilisateur> all) {
    return all.where((u) {
      final matchRole = _filtreRole == null || u.role == _filtreRole;
      final matchSearch =
          _search.isEmpty ||
          u.nom.toLowerCase().contains(_search.toLowerCase()) ||
          u.prenom.toLowerCase().contains(_search.toLowerCase());
      return matchRole && matchSearch;
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
    final async = ref.watch(utilisateursControllerProvider);
    final isLoading = async.isLoading;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Column(
      children: [
        Toolbar(
          showDetail: _showDetail,
          onSearch: (v) => setState(() => _search = v),
          onToggleDetail: () => setState(() => _showDetail = !_showDetail),
          onRefresh: () =>
              ref.read(utilisateursControllerProvider.notifier).refresh(),
          creer: null,
        ),
        const Divider(height: 1),

        // Filtre par rôle
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              FilterChip(
                label: const Text('Tous'),
                selected: _filtreRole == null,
                onSelected: (_) => setState(() => _filtreRole = null),
              ),
              const SizedBox(width: 8),
              ...roles.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(e.value.label),
                    selected: _filtreRole == e.key,
                    onSelected: (_) => setState(
                      () => _filtreRole = _filtreRole == e.key ? null : e.key,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                  ref.read(utilisateursControllerProvider.notifier).refresh(),
            ),
            data: (liste) {
              final filtres = _filtrer(liste);
              final master = _ListeUtilisateurs(
                liste: filtres,
                selectedId: _selectedId,
                onSelect: _selectItem,
              );

              if (!_showDetail) return master;

              final panelChild = _selectedId == null
                  ? Center(
                      child: FeedbackCard(
                        type: FeedbackType.info,
                        message:
                            "Sélectionnez un utilisateur pour afficher ses informations.",
                        dense: true,
                      ),
                    )
                  : _UtilisateurDetailContent(
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
                        type: "utilisateur",
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
                      type: "utilisateur",
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
class _ListeUtilisateurs extends StatelessWidget {
  final List<Utilisateur> liste;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const _ListeUtilisateurs({
    required this.liste,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (liste.isEmpty) {
      return const Center(
        child: FeedbackCard(
          icon: Icons.people_outline,
          type: FeedbackType.warning,
          title: "Aucun utilisateur",
          message: "Aucun utilisateur ne correspond aux critères.",
        ),
      );
    }

    return ListView.builder(
      itemCount: liste.length,
      itemBuilder: (_, i) {
        final u = liste[i];
        final isSelected = u.id == selectedId;
        final badge =
            roles[u.role] ?? const RoleBadge(BadgeEtatType.secondary, '?');

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Text(
              u.prenom[0].toUpperCase(),
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text('${u.prenom} ${u.nom}'),
          subtitle: Text(u.role),
          trailing: BadgeEtat(etat: badge.type, label: badge.label),
          selected: isSelected,
          selectedTileColor: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
          onTap: () => onSelect(u.id),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// DÉTAIL
// ════════════════════════════════════════════════════════════════
class _UtilisateurDetailContent extends ConsumerStatefulWidget {
  final String id;
  final VoidCallback onActionDone;

  const _UtilisateurDetailContent({
    required this.id,
    required this.onActionDone,
  });

  @override
  ConsumerState<_UtilisateurDetailContent> createState() =>
      _UtilisateurDetailContentState();
}

class _UtilisateurDetailContentState
    extends ConsumerState<_UtilisateurDetailContent> {
  bool _showRoleForm = false;
  String? _selectedRole;
  String? _selectedZoneId;
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    final utilisateur = ref.watch(utilisateurByIdProvider(widget.id));
    if (utilisateur == null) return const AppLoading();

    final badge =
        roles[utilisateur.role] ??
        const RoleBadge(BadgeEtatType.secondary, '?');
    final isTechnicien = utilisateur.role == "TECHNICIEN";

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Infos principales ──
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                utilisateur.prenom[0].toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${utilisateur.prenom} ${utilisateur.nom}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BadgeEtat(etat: badge.type, label: badge.label),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),

        if (utilisateur.createdAt != null)
          InfoRow("Membre depuis", dateConvert(utilisateur.createdAt!)),

        // ── Zone (technicien seulement) ──
        if (isTechnicien) ...[
          const SizedBox(height: 12),
          const Divider(),
          Text(
            'Zone gérée',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ref
              .watch(zoneTechnicienProvider(utilisateur.id))
              .when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text(
                  'Erreur : $e',
                  style: const TextStyle(color: Colors.red),
                ),
                data: (gerer) => gerer == null
                    ? const FeedbackCard(
                        type: FeedbackType.warning,
                        message: 'Aucune zone assignée à ce technicien.',
                        dense: true,
                      )
                    : ref
                          .watch(zonesDisponiblesProvider)
                          .when(
                            loading: () => const LinearProgressIndicator(),
                            error: (e, _) => const SizedBox.shrink(),
                            data: (zones) {
                              final zone = zones.firstWhere(
                                (z) => z.id == gerer.idZone,
                                orElse: () => throw Exception(),
                              );
                              return Column(
                                children: [
                                  InfoRow('Nom de la zone', zone.nom),
                                  if (zone.description != null)
                                    InfoRow('Description', zone.description!),
                                ],
                              );
                            },
                          ),
              ),
        ],

        // ── Actions ──
        const SizedBox(height: 24),
        const Divider(),
        Text(
          'Actions',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        if (!_showRoleForm) ...[
          OutlinedButton.icon(
            onPressed: () => setState(() {
              _showRoleForm = true;
              _selectedRole = utilisateur.role;
              _selectedZoneId = null;
            }),
            icon: const Icon(Icons.manage_accounts_outlined),
            label: const Text('Changer le rôle'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _supprimer(utilisateur.id),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Supprimer l\'utilisateur'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          ),
        ] else ...[
          _ChangerRoleForm(
            roleActuel: utilisateur.role,
            selectedRole: _selectedRole,
            selectedZoneId: _selectedZoneId,
            submitting: _submitting,
            onRoleChanged: (r) => setState(() {
              _selectedRole = r;
              _selectedZoneId = null;
            }),
            onZoneChanged: (z) => setState(() => _selectedZoneId = z),
            onConfirmer: () => _changerRole(utilisateur.id),
            onAnnuler: () => setState(() {
              _showRoleForm = false;
              _selectedRole = null;
              _selectedZoneId = null;
            }),
          ),
        ],
      ],
    );
  }

  Future<void> _changerRole(String idUtilisateur) async {
    if (_selectedRole == null) return;
    if (_selectedRole == "TECHNICIEN" && _selectedZoneId == null) {
      AppSnackBar.show(
        context,
        message: 'Veuillez sélectionner une zone pour ce technicien.',
        type: FeedbackType.error,
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref
          .read(utilisateursControllerProvider.notifier)
          .changerRole(
            idUtilisateur: idUtilisateur,
            nouveauRole: _selectedRole!,
          );

      // Gérer la zone si technicien
      final service = ref.read(utilisateursServiceProvider);
      if (_selectedRole == "TECHNICIEN") {
        await service.assignerZone(
          idUtilisateur: idUtilisateur,
          idZone: _selectedZoneId!,
        );
      } else {
        await service.retirerZone(idUtilisateur: idUtilisateur);
      }

      ref.invalidate(zoneTechnicienProvider(idUtilisateur));

      if (!mounted) return;
      setState(() {
        _showRoleForm = false;
        _selectedRole = null;
        _selectedZoneId = null;
      });
      AppSnackBar.show(
        context,
        message: 'Rôle mis à jour avec succès.',
        type: FeedbackType.success,
      );
    } catch (_) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: 'Erreur lors du changement de rôle.',
        type: FeedbackType.error,
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _supprimer(String idUtilisateur) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'utilisateur'),
        content: const Text(
          'Voulez-vous vraiment supprimer cet utilisateur ? Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmation != true) return;

    try {
      await ref
          .read(utilisateursControllerProvider.notifier)
          .supprimerUtilisateur(idUtilisateur: idUtilisateur);
      if (!mounted) return;
      widget.onActionDone();
      AppSnackBar.show(
        context,
        message: 'Utilisateur supprimé.',
        type: FeedbackType.success,
      );
    } catch (_) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: 'Erreur lors de la suppression.',
        type: FeedbackType.error,
      );
    }
  }
}

// ════════════════════════════════════════════════════════════════
// FORMULAIRE CHANGER RÔLE
// ════════════════════════════════════════════════════════════════
class _ChangerRoleForm extends ConsumerWidget {
  final String roleActuel;
  final String? selectedRole;
  final String? selectedZoneId;
  final bool submitting;
  final ValueChanged<String?> onRoleChanged;
  final ValueChanged<String?> onZoneChanged;
  final VoidCallback onConfirmer;
  final VoidCallback onAnnuler;

  const _ChangerRoleForm({
    required this.roleActuel,
    required this.selectedRole,
    required this.selectedZoneId,
    required this.submitting,
    required this.onRoleChanged,
    required this.onZoneChanged,
    required this.onConfirmer,
    required this.onAnnuler,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Nouveau rôle',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        // Radio rôles
        ...roles.entries.map(
          (e) => RadioListTile<String>(
            value: e.key,
            groupValue: selectedRole,
            title: Text(e.value.label),
            onChanged: onRoleChanged,
            dense: true,
          ),
        ),

        // Zone si technicien sélectionné
        if (selectedRole == "TECHNICIEN") ...[
          const SizedBox(height: 12),
          Text(
            'Zone à gérer *',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ref
              .watch(zonesDisponiblesProvider)
              .when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text(
                  'Erreur zones : $e',
                  style: const TextStyle(color: Colors.red),
                ),
                data: (zones) => zones.isEmpty
                    ? const FeedbackCard(
                        type: FeedbackType.warning,
                        message: 'Aucune zone disponible.',
                        dense: true,
                      )
                    : SizedBox(
                        height: 200,
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          itemCount: zones.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final zone = zones[i];
                            return RadioListTile<String>(
                              value: zone.id,
                              groupValue: selectedZoneId,
                              title: Text(zone.nom),
                              subtitle: zone.description != null
                                  ? Text(zone.description!)
                                  : null,
                              onChanged: onZoneChanged,
                              dense: true,
                            );
                          },
                        ),
                      ),
              ),
        ],

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: submitting ? null : onAnnuler,
                child: const Text('Annuler'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                onPressed: submitting ? null : onConfirmer,
                child: submitting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Confirmer'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
