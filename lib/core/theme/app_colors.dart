import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const primary = Color(0xFF3F51B5);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFE8EAF6);
  static const onPrimaryContainer = Color(0xFF1A237E);

  // Sémantiques
  static const success = Color(0xFF2E7D32);
  static const successLight = Color(0xFFE8F5E9);
  static const warning = Color(0xFFE65100);
  static const warningLight = Color(0xFFFFF3E0);
  static const danger = Color(0xFFC62828);
  static const dangerLight = Color(0xFFFFEBEE);
  static const info = Color(0xFF0277BD);
  static const infoLight = Color(0xFFE1F5FE);

  // Neutres
  static const surface = Color(0xFFF5F5F5);
  static const surfaceWhite = Color(0xFFFFFFFF);
  static const outline = Color(0xFFE0E0E0);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textDisabled = Color(0xFFBDBDBD);

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