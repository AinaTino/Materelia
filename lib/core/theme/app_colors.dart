import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const primary = Color(0xFF1E88E5);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFDCEFFF);
  static const onPrimaryContainer = Color(0xFF002F6C);

  // Secondary
  static const secondary = Color(0xFF26A69A);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFB2DFDB);
  static const onSecondaryContainer = Color(0xFF00332B);

  // Semantic
  static const success = Color(0xFF2E7D32);
  static const successLight = Color(0xFFE8F5E9);
  static const warning = Color(0xFFF57C00);
  static const warningLight = Color(0xFFFFF3E0);
  static const danger = Color(0xFFB00020);
  static const dangerLight = Color(0xFFFCD8DD);
  static const info = Color(0xFF0288D1);
  static const infoLight = Color(0xFFE1F5FE);

  // Neutres
  static const surface = Color(0xFFF4F8FF);
  static const surfaceWhite = Color(0xFFFFFFFF);
  static const background = Color(0xFFF1F5FF);
  static const surfaceVariant = Color(0xFFE3E9F7);
  static const onSurfaceVariant = Color(0xFF484F5A);
  static const outline = Color(0xFF9BB3D0);
  static const textPrimary = Color(0xFF1B1F3B);
  static const textSecondary = Color(0xFF5F6678);
  static const textDisabled = Color(0xFF9AA3B1);

  // Badge par état ticket/affectation
  static Color badgeForeground(String etat) {
    switch (etat) {
      case 'EN_ATTENTE': return warning;
      case 'VALIDE':     return info;
      case 'EN_COURS':   return success;
      case 'RENDU':      return textSecondary;
      case 'EXPIRE':     return danger;
      case 'REFUSE':     return danger;
      case 'ACTIVE':     return success;
      case 'EXPIREE':    return danger;
      case 'REVOQUEE':   return danger;
      default:           return textSecondary;
    }
  }

  static Color badgeBackground(String etat) {
    switch (etat) {
      case 'EN_ATTENTE': return warningLight;
      case 'VALIDE':     return infoLight;
      case 'EN_COURS':   return successLight;
      case 'RENDU':      return surface;
      case 'EXPIRE':     return dangerLight;
      case 'REFUSE':     return dangerLight;
      case 'ACTIVE':     return successLight;
      case 'EXPIREE':    return dangerLight;
      case 'REVOQUEE':   return dangerLight;
      default:           return surface;
    }
  }
}