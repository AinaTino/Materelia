// lib/features/apropos/UI/apropos_page.dart

import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════════════
// NAVIGATION SECTIONS
// ══════════════════════════════════════════════════════════════

class _Section {
  final String id;
  final String label;
  final IconData icon;
  const _Section(this.id, this.label, this.icon);
}

const _sections = [
  _Section('bienvenue', 'Bienvenue', Icons.waving_hand_outlined),
  _Section('emprunt', 'Emprunter', Icons.shopping_cart_outlined),
  _Section('affectation', 'Affectations', Icons.assignment_outlined),
  _Section('regles', 'Règles à savoir', Icons.lightbulb_outline),
  _Section('faq', 'FAQ', Icons.help_outline),
  _Section('contact', 'Contact', Icons.mail_outline),
];

// ══════════════════════════════════════════════════════════════
// PAGE PRINCIPALE
// ══════════════════════════════════════════════════════════════

class AproposPage extends StatefulWidget {
  const AproposPage({super.key});

  @override
  State<AproposPage> createState() => _AproposPageState();
}

class _AproposPageState extends State<AproposPage> {
  final _scrollController = ScrollController();
  final Map<String, GlobalKey> _keys = {
    for (final s in _sections) s.id: GlobalKey(),
  };
  String _activeSection = 'bienvenue';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    for (final s in _sections.reversed) {
      final key = _keys[s.id];
      if (key?.currentContext == null) continue;
      final box = key!.currentContext!.findRenderObject() as RenderBox?;
      if (box == null) continue;
      if (box.localToGlobal(Offset.zero).dy <= 200) {
        if (_activeSection != s.id) setState(() => _activeSection = s.id);
        break;
      }
    }
  }

  void _scrollTo(String id) {
    final key = _keys[id];
    if (key?.currentContext == null) return;
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    final content = SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(key: _keys['bienvenue']),
          _SectionBlock(
            sectionKey: _keys['emprunt']!,
            title: 'Comment emprunter du matériel ?',
            icon: Icons.shopping_cart_outlined,
            child: const _GuideEmprunt(),
          ),
          _SectionBlock(
            sectionKey: _keys['affectation']!,
            title: 'Les affectations longue durée',
            icon: Icons.assignment_outlined,
            child: const _GuideAffectation(),
          ),
          _SectionBlock(
            sectionKey: _keys['regles']!,
            title: 'Ce qu\'il faut savoir',
            icon: Icons.lightbulb_outline,
            child: const _ReglesUtilisateur(),
          ),
          _SectionBlock(
            sectionKey: _keys['faq']!,
            title: 'Questions fréquentes',
            icon: Icons.help_outline,
            child: const _FaqContent(),
          ),
          _SectionBlock(
            sectionKey: _keys['contact']!,
            title: 'L\'équipe',
            icon: Icons.mail_outline,
            child: const _ContactContent(),
          ),
        ],
      ),
    );

    if (!isDesktop) return content;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 196,
          child: _SideNav(
            sections: _sections,
            activeId: _activeSection,
            onTap: _scrollTo,
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(child: content),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
// SIDEBAR (desktop)
// ══════════════════════════════════════════════════════════════

class _SideNav extends StatelessWidget {
  final List<_Section> sections;
  final String activeId;
  final ValueChanged<String> onTap;

  const _SideNav({
    required this.sections,
    required this.activeId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: sections.map((s) {
        final active = s.id == activeId;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: active
                ? cs.primaryContainer.withValues(alpha: 0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              s.icon,
              size: 18,
              color: active ? cs.primary : cs.onSurfaceVariant,
            ),
            title: Text(
              s.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                color: active ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
            onTap: () => onTap(s.id),
          ),
        );
      }).toList(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// HERO
// ══════════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  const _HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cs.primaryContainer.withValues(alpha: 0.55), cs.surface],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: cs.surface,
            backgroundImage: const AssetImage(
              'lib/assets/images/logo-nobg.png',
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'MateRelia',
            style: tt.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Votre gestionnaire de matériels informatiques',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Text(
              'MateRelia vous permet d\'emprunter du matériel informatique '
              'pour une courte durée, ou de demander une affectation longue durée '
              'si vous en avez un besoin régulier. '
              'Tout se passe depuis cette application : demande, suivi, '
              'récupération et retour.',
              style: tt.bodyMedium?.copyWith(color: cs.onSurface, height: 1.65),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PillBadge(Icons.bolt_outlined, 'Temps réel', cs),
              const SizedBox(width: 8),
              _PillBadge(Icons.lock_outline, 'Sécurisé', cs),
              const SizedBox(width: 8),
              _PillBadge(Icons.devices_outlined, 'Multi-appareils', cs),
            ],
          ),
        ],
      ),
    );
  }
}

class _PillBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme cs;
  const _PillBadge(this.icon, this.label, this.cs);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: cs.secondary),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: cs.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// BLOC SECTION GÉNÉRIQUE
// ══════════════════════════════════════════════════════════════

class _SectionBlock extends StatelessWidget {
  final GlobalKey sectionKey;
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionBlock({
    required this.sectionKey,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      key: sectionKey,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, size: 18, color: cs.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// GUIDE EMPRUNT
// ══════════════════════════════════════════════════════════════

class _GuideEmprunt extends StatelessWidget {
  const _GuideEmprunt();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoBanner(
          icon: Icons.info_outline,
          color: cs.primary,
          bgColor: cs.primaryContainer.withValues(alpha: 0.35),
          text:
              'L\'emprunt est fait pour un usage ponctuel. Vous choisissez une catégorie de matériel (ex. "Ordinateur portable"), pas un modèle précis — c\'est l\'application qui vous en attribue un disponible.',
        ),
        const SizedBox(height: 16),
        _StepList(
          steps: const [
            _StepData(
              'Ouvrez le Catalogue',
              'Depuis le menu, accédez au Catalogue. Vous y voyez les catégories de matériels disponibles à l\'emprunt.',
              Icons.storefront_outlined,
            ),
            _StepData(
              'Ajoutez au panier',
              'Appuyez sur les catégories qui vous intéressent pour les ajouter à votre panier.',
              Icons.add_shopping_cart_outlined,
            ),
            _StepData(
              'Validez votre panier',
              'Dans votre Panier, indiquez le lieu où vous allez utiliser le matériel et la date à laquelle vous comptez le rendre, puis validez.',
              Icons.check_circle_outline,
            ),
            _StepData(
              'Attendez la validation',
              'Votre demande part au technicien responsable. Il la valide ou la refuse. Vous recevez une notification.',
              Icons.hourglass_empty_outlined,
            ),
            _StepData(
              'Récupérez le matériel',
              'Si votre demande est validée, vous recevez un code à 6 chiffres. Présentez-vous au point de remise, saisissez ce code et récupérez votre matériel.',
              Icons.pin_outlined,
            ),
            _StepData(
              'Rendez le matériel',
              'À la fin de votre utilisation, rapportez le matériel. Un technicien confirme le retour.',
              Icons.keyboard_return_outlined,
            ),
          ],
        ),
        const SizedBox(height: 14),
        _InfoBanner(
          icon: Icons.timer_outlined,
          color: Colors.orange.shade700,
          bgColor: Colors.orange.withValues(alpha: 0.08),
          text:
              'Attention : une fois votre demande validée, vous avez exactement 24h pour venir récupérer le matériel avec votre code. Passé ce délai, la demande expire et le matériel est remis à disposition.',
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
// GUIDE AFFECTATION
// ══════════════════════════════════════════════════════════════

class _GuideAffectation extends StatelessWidget {
  const _GuideAffectation();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoBanner(
          icon: Icons.info_outline,
          color: cs.primary,
          bgColor: cs.primaryContainer.withValues(alpha: 0.35),
          text:
              'Une affectation vous attribue un matériel pour une durée prolongée (90 jours par défaut). C\'est adapté si vous avez besoin d\'un équipement de façon régulière — un écran, un ordinateur fixe, une imprimante...',
        ),
        const SizedBox(height: 16),
        _StepList(
          steps: const [
            _StepData(
              'Faites une demande',
              'Dans "Mes demandes d\'affectation", appuyez sur "Nouvelle demande". Choisissez la catégorie de matériel, votre service et indiquez pourquoi vous en avez besoin.',
              Icons.add_circle_outline,
            ),
            _StepData(
              'L\'administrateur examine',
              'Votre demande est transmise à un administrateur, qui choisit le matériel précis à vous attribuer.',
              Icons.admin_panel_settings_outlined,
            ),
            _StepData(
              'Validation ou refus',
              'Vous recevez une notification avec la décision. En cas de refus, un motif vous est communiqué.',
              Icons.notifications_outlined,
            ),
            _StepData(
              'Affectation active',
              'Si validée, votre affectation démarre et est visible dans "Mes affectations". Elle dure 90 jours.',
              Icons.assignment_turned_in_outlined,
            ),
            _StepData(
              'Renouvellement ou fin',
              'À l\'approche de l\'expiration, l\'administrateur peut renouveler votre affectation pour 90 jours supplémentaires, ou y mettre fin.',
              Icons.update_outlined,
            ),
          ],
        ),
        const SizedBox(height: 14),
        _RuleCard(
          titre: 'Durée fixe de 90 jours',
          desc:
              'Chaque affectation dure exactement 90 jours. En cas de renouvellement, 90 jours supplémentaires sont ajoutés à partir de la date d\'expiration précédente.',
          icon: Icons.calendar_today_outlined,
          color: cs.primary,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Révocation possible à tout moment',
          desc:
              'L\'administrateur peut mettre fin à votre affectation avant son terme si nécessaire. Vous en êtes notifié immédiatement.',
          icon: Icons.cancel_outlined,
          color: Colors.red.shade600,
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
// RÈGLES UTILISATEUR
// ══════════════════════════════════════════════════════════════

class _ReglesUtilisateur extends StatelessWidget {
  const _ReglesUtilisateur();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SoustitreSec('Concernant les emprunts', context),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Vous choisissez une catégorie, pas un matériel',
          desc:
              'Le système sélectionne automatiquement un matériel disponible dans la catégorie choisie. Vous ne pouvez pas demander un équipement précis.',
          icon: Icons.category_outlined,
          color: cs.primary,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: '24h pour récupérer votre matériel',
          desc:
              'Dès que votre demande est validée par le technicien, vous avez 24h pour vous présenter avec votre code. Au-delà, la demande expire et le matériel est remis en stock.',
          icon: Icons.timer_outlined,
          color: Colors.orange.shade700,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Un technicien peut refuser votre demande',
          desc:
              'Si votre demande ne peut pas être satisfaite, le technicien la refuse avec un motif. Vous en êtes notifié et pouvez refaire une demande.',
          icon: Icons.block_outlined,
          color: Colors.red.shade600,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Le retour doit être confirmé',
          desc:
              'Rapporter le matériel ne suffit pas : un technicien doit confirmer le retour physique. C\'est à ce moment que le matériel est officiellement rendu.',
          icon: Icons.fact_check_outlined,
          color: Colors.green.shade700,
        ),
        const SizedBox(height: 18),
        _SoustitreSec('Concernant les affectations', context),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Durée standard de 90 jours',
          desc:
              'Toute affectation dure 90 jours. Ce délai est fixé par l\'administration et ne peut pas être modifié à la demande.',
          icon: Icons.date_range_outlined,
          color: cs.primary,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Renouvellement non automatique',
          desc:
              'Votre affectation ne se renouvelle pas automatiquement à l\'échéance. L\'administrateur doit décider de la renouveler ou non.',
          icon: Icons.loop_outlined,
          color: Colors.orange.shade700,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Un matériel à la fois par affectation',
          desc:
              'Chaque demande d\'affectation aboutit à l\'attribution d\'un seul matériel. Pour plusieurs équipements, faites plusieurs demandes.',
          icon: Icons.devices_outlined,
          color: Colors.blue.shade700,
        ),
        const SizedBox(height: 18),
        _SoustitreSec('Règles générales', context),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Un matériel déjà pris ne peut pas être redemandé',
          desc:
              'Si un matériel est en cours d\'emprunt ou d\'affectation, il n\'apparaît pas comme disponible dans le catalogue.',
          icon: Icons.lock_outline,
          color: Colors.grey.shade700,
        ),
        const SizedBox(height: 8),
        _RuleCard(
          titre: 'Les notifications vous tiennent informé',
          desc:
              'Toutes les actions importantes (validation, refus, expiration, fin d\'affectation) vous sont communiquées via les notifications dans l\'application.',
          icon: Icons.notifications_active_outlined,
          color: cs.secondary,
        ),
      ],
    );
  }
}

Widget _SoustitreSec(String titre, BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final tt = Theme.of(context).textTheme;
  return Row(
    children: [
      Container(
        width: 3,
        height: 16,
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        titre,
        style: tt.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
        ),
      ),
    ],
  );
}

// ══════════════════════════════════════════════════════════════
// FAQ
// ══════════════════════════════════════════════════════════════

class _FaqContent extends StatelessWidget {
  const _FaqContent();

  static const _items = [
    _FaqItem(
      'Je n\'ai pas pu récupérer mon matériel à temps. Que faire ?',
      'Si votre code de remise a expiré (24h dépassées), votre ticket passe automatiquement en "Expiré". Vous devez refaire une demande depuis le Catalogue. Le matériel a été remis à disposition.',
    ),
    _FaqItem(
      'Ma demande d\'emprunt a été refusée. Pourquoi ?',
      'Le technicien de votre zone a indiqué un motif de refus visible dans le détail du ticket. Cela peut arriver si le matériel n\'est plus disponible ou si votre demande est incomplète.',
    ),
    _FaqItem(
      'Combien de temps dure une affectation ?',
      '90 jours à partir de la date de début. L\'administrateur peut la renouveler (90 jours supplémentaires) ou y mettre fin avant l\'échéance.',
    ),
    _FaqItem(
      'Puis-je choisir un matériel précis ?',
      'Non. Vous choisissez une catégorie (ex. "PC portable") et le système vous attribue un matériel disponible dans cette catégorie. Cela permet une gestion équitable du parc.',
    ),
    _FaqItem(
      'Où est mon code de remise ?',
      'Une fois votre ticket validé par le technicien, vous recevez une notification. Le code apparaît également dans le détail de votre ticket dans "Mes Tickets".',
    ),
    _FaqItem(
      'Mon affectation expire bientôt. Que se passe-t-il ?',
      'L\'administrateur est notifié 7 jours avant l\'expiration. Si votre affectation n\'est pas renouvelée, elle passe à "Expirée" à la date prévue et le matériel est repris.',
    ),
    _FaqItem(
      'Je veux annuler ma demande d\'affectation. Comment faire ?',
      'Tant que votre demande est en attente de traitement, vous pouvez la supprimer depuis "Mes demandes d\'affectation". Une fois validée ou refusée, la suppression n\'est plus possible.',
    ),
    _FaqItem(
      'Qui traite mes tickets d\'emprunt ?',
      'Les techniciens assignés à la zone où se trouve le matériel. N\'importe quel technicien de cette zone peut traiter votre ticket.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: _items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 2,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            leading: Icon(Icons.help_outline, color: cs.primary, size: 18),
            title: Text(
              item.question,
              style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            children: [
              Text(
                item.reponse,
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _FaqItem {
  final String question;
  final String reponse;
  const _FaqItem(this.question, this.reponse);
}

// ══════════════════════════════════════════════════════════════
// CONTACT
// ══════════════════════════════════════════════════════════════

class _ContactContent extends StatelessWidget {
  const _ContactContent();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Développée par',
                style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              _MembreCard(
                'T',
                'Tino',
                'Chef de projet · Architecture · Backend · Auth · Dashboard',
                cs,
              ),
              const SizedBox(height: 10),
              _MembreCard('J', 'Jocelyn', 'Tickets · Panier · Matériels', cs),
              const SizedBox(height: 10),
              _MembreCard(
                'R',
                'Rojotiana',
                'Contributeur · Tests · Support',
                cs,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(Icons.school_outlined, color: cs.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Projet IHM · ENI Fianarantsoa',
                      style: tt.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Informatique Générale',
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_outlined, color: cs.secondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Vos données sont hébergées sur Supabase et ne sont jamais partagées avec des tiers. '
                  'Cette application est un projet académique à usage interne.',
                  style: tt.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _MembreCard(String initiale, String nom, String role, ColorScheme cs) {
  return Builder(
    builder: (context) {
      final tt = Theme.of(context).textTheme;
      return Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: cs.primaryContainer,
            child: Text(
              initiale,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: cs.onPrimaryContainer,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nom,
                  style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  role,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

// ══════════════════════════════════════════════════════════════
// COMPOSANTS RÉUTILISABLES
// ══════════════════════════════════════════════════════════════

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String text;

  const _InfoBanner({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: tt.bodySmall?.copyWith(
                height: 1.6,
                color: color.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  final String titre;
  final String desc;
  final IconData icon;
  final Color color;

  const _RuleCard({
    required this.titre,
    required this.desc,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: tt.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String titre;
  final String desc;
  final IconData icon;
  const _StepData(this.titre, this.desc, this.icon);
}

class _StepList extends StatelessWidget {
  final List<_StepData> steps;
  const _StepList({required this.steps});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: steps.asMap().entries.map((e) {
        final i = e.key;
        final step = e.value;
        final isLast = i == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 34,
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(width: 2, color: cs.outlineVariant),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16, top: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(step.icon, size: 13, color: cs.primary),
                          const SizedBox(width: 5),
                          Text(
                            step.titre,
                            style: tt.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        step.desc,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
