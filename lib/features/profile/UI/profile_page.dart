import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:materelia/core/theme/app_colors.dart';
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
      data: (utilisateur) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryContainer.withValues(alpha: 0.55),
              AppColors.secondaryContainer.withValues(alpha: 0.28),
              AppColors.surface,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: _ProfilContent(utilisateur: utilisateur),
            ),
          ),
        ),
      ),
    );
  }
}

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
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isDesktop ? 32 : 20),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: _ProfileHeader(
                          utilisateur: u,
                          badgeType: badgeType,
                          badgeLabel: badgeLabel,
                          editMode: _editMode,
                          onEdit: () => setState(() => _editMode = true),
                        ),
                      ),
                      const SizedBox(width: 28),
                      SizedBox(
                        height: isTechnicien ? 430 : 300,
                        child: VerticalDivider(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        child: _ProfileDetails(
                          editMode: _editMode,
                          formKey: _formKey,
                          nomCtrl: _nomCtrl,
                          prenomCtrl: _prenomCtrl,
                          submitting: _submitting,
                          onSave: _save,
                          onCancel: _cancelEdit,
                          utilisateur: u,
                          isTechnicien: isTechnicien,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProfileHeader(
                        utilisateur: u,
                        badgeType: badgeType,
                        badgeLabel: badgeLabel,
                        editMode: _editMode,
                        onEdit: () => setState(() => _editMode = true),
                      ),
                      const SizedBox(height: 24),
                      _ProfileDetails(
                        editMode: _editMode,
                        formKey: _formKey,
                        nomCtrl: _nomCtrl,
                        prenomCtrl: _prenomCtrl,
                        submitting: _submitting,
                        onSave: _save,
                        onCancel: _cancelEdit,
                        utilisateur: u,
                        isTechnicien: isTechnicien,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _cancelEdit() {
    setState(() {
      _editMode = false;
      _nomCtrl.text = widget.utilisateur.nom;
      _prenomCtrl.text = widget.utilisateur.prenom;
    });
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

class _ProfileHeader extends StatelessWidget {
  final Utilisateur utilisateur;
  final BadgeEtatType badgeType;
  final String badgeLabel;
  final bool editMode;
  final VoidCallback onEdit;

  const _ProfileHeader({
    required this.utilisateur,
    required this.badgeType,
    required this.badgeLabel,
    required this.editMode,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final initial = utilisateur.prenom.trim().isNotEmpty
        ? utilisateur.prenom.trim()[0].toUpperCase()
        : '?';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: colorScheme.primary,
              child: Text(
                initial,
                style: textTheme.displaySmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${utilisateur.prenom} ${utilisateur.nom}',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          BadgeEtat(etat: badgeType, label: badgeLabel),
          if (utilisateur.createdAt != null) ...[
            const SizedBox(height: 10),
            Text(
              'Membre depuis ${dateConvert(utilisateur.createdAt!)}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (!editMode) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Modifier le profil'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final bool editMode;
  final GlobalKey<FormState> formKey;
  final TextEditingController nomCtrl;
  final TextEditingController prenomCtrl;
  final bool submitting;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Utilisateur utilisateur;
  final bool isTechnicien;

  const _ProfileDetails({
    required this.editMode,
    required this.formKey,
    required this.nomCtrl,
    required this.prenomCtrl,
    required this.submitting,
    required this.onSave,
    required this.onCancel,
    required this.utilisateur,
    required this.isTechnicien,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ProfilePanel(
          icon: editMode ? Icons.edit_note_outlined : Icons.account_box_outlined,
          title: editMode ? 'Modifier mes informations' : 'Informations',
          child: editMode
              ? _EditForm(
                  formKey: formKey,
                  nomCtrl: nomCtrl,
                  prenomCtrl: prenomCtrl,
                  submitting: submitting,
                  onSave: onSave,
                  onCancel: onCancel,
                )
              : _InfosView(utilisateur: utilisateur),
        ),
        if (isTechnicien) ...[
          const SizedBox(height: 18),
          const _ZoneCard(),
        ],
      ],
    );
  }
}

class _ProfilePanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _ProfilePanel({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: colorScheme.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

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

class _ZoneCard extends ConsumerWidget {
  const _ZoneCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ProfilePanel(
      icon: Icons.warehouse_outlined,
      title: 'Zone gérée',
      child: ref
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
    );
  }
}

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
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: colorScheme.primary),
        ),
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
              const SizedBox(height: 3),
              Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
