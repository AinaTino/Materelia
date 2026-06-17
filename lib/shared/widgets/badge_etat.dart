import 'package:flutter/material.dart';
import 'package:materelia/core/theme/app_colors.dart';

enum BadgeEtatType { primary, secondary, warning, error, success }

extension BadgeEtatStyle on BadgeEtatType {
  ({Color text, Color bg}) get colors {
    switch (this) {
      case BadgeEtatType.primary:
        return (text: Color(0xFF1565C0), bg: Color(0xFFE3F2FD));
      case BadgeEtatType.secondary:
        return (text: Color(0xFF6A1B9A), bg: Color(0xFFF3E5F5));
      case BadgeEtatType.success:
        return (text: Color(0xFF2E7D32), bg: Color(0xFFE8F5E9));
      case BadgeEtatType.warning:
        return (text: Color(0xFFE65100), bg: Color(0xFFFFF3E0));
      case BadgeEtatType.error:
        return (text: Color(0xFFC62828), bg: Color(0xFFFFEBEE));
    }
  }
}

class BadgeEtat extends StatelessWidget {
  final String? etat;
  final BadgeEtatType? type;
  final String? label;

  // Constructeur pour les pages de Tino (avec enum)
  const BadgeEtat({
    super.key,
    BadgeEtatType? etat,
    String? label,
    String? etatString,
  })  : etat = etatString ?? (etat != null ? null : ''),
        type = etat,
        label = label;

  // Constructeur nommé pour tes pages (avec String)
  const BadgeEtat.string({super.key, required String etat})
      : etat = etat,
        type = null,
        label = null;

  String _getLabelFromString(String etat) {
    switch (etat) {
      case 'EN_ATTENTE':
        return 'En attente';
      case 'VALIDE':
        return 'Validé';
      case 'EN_COURS':
        return 'En cours';
      case 'RENDU':
        return 'Rendu';
      case 'EXPIRE':
        return 'Expiré';
      case 'REFUSE':
        return 'Refusé';
      case 'ACTIVE':
        return 'Actif';
      case 'EXPIREE':
        return 'Expirée';
      case 'REVOQUEE':
        return 'Révoquée';
      default:
        return etat;
    }
  }

  Color _getTextColorFromString(String etat) {
    switch (etat) {
      case 'EN_ATTENTE':
        return AppColors.warning;
      case 'VALIDE':
        return AppColors.info;
      case 'EN_COURS':
      case 'ACTIVE':
        return AppColors.success;
      case 'RENDU':
        return AppColors.textSecondary;
      case 'EXPIRE':
      case 'EXPIREE':
      case 'REFUSE':
      case 'REVOQUEE':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getBackgroundColorFromString(String etat) {
    switch (etat) {
      case 'EN_ATTENTE':
        return AppColors.warningContainer;
      case 'VALIDE':
        return AppColors.infoContainer;
      case 'EN_COURS':
      case 'ACTIVE':
        return AppColors.successContainer;
      case 'RENDU':
        return AppColors.surfaceContainer;
      case 'EXPIRE':
      case 'EXPIREE':
      case 'REFUSE':
      case 'REVOQUEE':
        return AppColors.errorContainer;
      default:
        return AppColors.surfaceContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si on utilise l'enum (pages de Tino)
    if (type != null && label != null) {
      final style = type!.colors;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: style.bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label!,
          style: TextStyle(
            color: style.text,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      );
    }

    // Sinon, on utilise le String (tes pages)
    final currentEtat = etat ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColorFromString(currentEtat),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getLabelFromString(currentEtat),
        style: TextStyle(
          color: _getTextColorFromString(currentEtat),
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}