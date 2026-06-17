import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/features/profile/provider/profile_provider.dart';
import 'package:materelia/shared/models/utilisateur.dart';
import 'package:materelia/shared/tools/date_convert.dart';
import 'package:materelia/shared/widgets/app_snack_bar.dart';
import 'package:materelia/shared/widgets/badge_etat.dart';
import 'package:materelia/shared/widgets/feedback_card.dart';
import 'package:materelia/shared/widgets/loading.dart';

const _roleLabels = {
  'simple': (BadgeEtatType.secondary, 'Simple'),
  'technicien': (BadgeEtatType.warning, 'Technicien'),
  'admin': (BadgeEtatType.success, 'Admin'),
};

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(profileControllerProvider);

    return async.when(
      loading: () => const AppLoading(),
      error: (e, _) => Center(
        child: FeedbackCard(type: FeedbackType.error, message: e.toString()),
      ),
      data: (utilisateur) => Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: _ProfilContent(utilisateur: utilisateur),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CONTENU PROFIL
// ════════════════════════════════════════════════════════════════
class _ProfilContent extends ConsumerStatefulWidget {
  final Utilisateur utilisateur;

  const _ProfilContent({required this.utilisateur});

  @override
  ConsumerState<_ProfilContent> createState() => _ProfilContentState();
}

class _ProfilContentState extends ConsumerState<_ProfilContent> {
  bool _editMode = false;
  bool _submitting = false;
  late final TextEditingController _nomCtrl;
  late final TextEditingController _prenomCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomCtrl = TextEditingController(text: widget.utilisateur.nom);
    _prenomCtrl = TextEditingController(text: widget.utilisateur.prenom);
  }

  @override
  void dispose() {
    _nomCtrl.dispose();
    _prenomCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final u = widget.utilisateur;
    final (badgeType, badgeLabel) =
        _roleLabels[u.role] ?? (BadgeEtatType.secondary, u.role);
    final isTechnicien = u.role == 'technicien';
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Avatar + nom + badge ──────────────────────────────
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  u.prenom[0].toUpperCase(),
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${u.prenom} ${u.nom}',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              BadgeEtat(etat: badgeType, label: badgeLabel),
              if (u.createdAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  'Membre depuis ${dateConvert(u.createdAt!)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 32),

        // ── Card infos / édition ──────────────────────────────
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _editMode
                ? _EditForm(
                    formKey: _formKey,
                    nomCtrl: _nomCtrl,
                    prenomCtrl: _prenomCtrl,
                    submitting: _submitting,
                    onSave: _save,
                    onCancel: () => setState(() {
                      _editMode = false;
                      _nomCtrl.text = widget.utilisateur.nom;
                      _prenomCtrl.text = widget.utilisateur.prenom;
                    }),
                  )
                : _InfosView(utilisateur: u),
          ),
        ),

        if (!_editMode) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => setState(() => _editMode = true),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Modifier le profil'),
          ),
        ],

        // ── Card zone (technicien) ────────────────────────────
        if (isTechnicien) ...[const SizedBox(height: 20), _ZoneCard()],
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      await ref
          .read(profileControllerProvider.notifier)
          .updateProfil(
            nom: _nomCtrl.text.trim(),
            prenom: _prenomCtrl.text.trim(),
          );
      if (!mounted) return;
      setState(() => _editMode = false);
      AppSnackBar.show(
        context,
        message: 'Profil mis à jour.',
        type: FeedbackType.success,
      );
    } catch (_) {
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: 'Erreur lors de la mise à jour.',
        type: FeedbackType.error,
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

// ════════════════════════════════════════════════════════════════
// VUE INFOS (lecture)
// ════════════════════════════════════════════════════════════════
class _InfosView extends StatelessWidget {
  final Utilisateur utilisateur;

  const _InfosView({required this.utilisateur});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfilRow(
          icon: Icons.person_outline,
          label: 'Prénom',
          value: utilisateur.prenom,
        ),
        const Divider(height: 24),
        _ProfilRow(
          icon: Icons.badge_outlined,
          label: 'Nom',
          value: utilisateur.nom,
        ),
        const Divider(height: 24),
        _ProfilRow(
          icon: Icons.shield_outlined,
          label: 'Rôle',
          value: utilisateur.role,
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// FORMULAIRE ÉDITION
// ════════════════════════════════════════════════════════════════
class _EditForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomCtrl;
  final TextEditingController prenomCtrl;
  final bool submitting;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const _EditForm({
    required this.formKey,
    required this.nomCtrl,
    required this.prenomCtrl,
    required this.submitting,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: prenomCtrl,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Champ obligatoire' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: nomCtrl,
            decoration: const InputDecoration(
              labelText: 'Nom',
              prefixIcon: Icon(Icons.badge_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Champ obligatoire' : null,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: submitting ? null : onCancel,
                  child: const Text('Annuler'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: submitting ? null : onSave,
                  child: submitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CARD ZONE TECHNICIEN
// ════════════════════════════════════════════════════════════════
class _ZoneCard extends ConsumerWidget {
  const _ZoneCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Icon(Icons.warehouse_outlined, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Zone gérée',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ref
                .watch(zoneGereeProvider)
                .when(
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text(
                    'Erreur : $e',
                    style: const TextStyle(color: Colors.red),
                  ),
                  data: (gerer) => gerer == null
                      ? const FeedbackCard(
                          type: FeedbackType.warning,
                          message: 'Aucune zone ne vous est assignée.',
                          dense: true,
                        )
                      : ref
                            .watch(zoneByIdProvider(gerer.idZone))
                            .when(
                              loading: () => const LinearProgressIndicator(),
                              error: (e, _) => Text(
                                'Erreur : $e',
                                style: const TextStyle(color: Colors.red),
                              ),
                              data: (zone) => Column(
                                children: [
                                  _ProfilRow(
                                    icon: Icons.location_on_outlined,
                                    label: 'Nom',
                                    value: zone.nom,
                                  ),
                                  if (zone.description != null) ...[
                                    const Divider(height: 24),
                                    _ProfilRow(
                                      icon: Icons.info_outline,
                                      label: 'Description',
                                      value: zone.description!,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// WIDGET LIGNE PROFIL
// ════════════════════════════════════════════════════════════════
class _ProfilRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfilRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
