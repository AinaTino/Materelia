import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // BRAND
  // ---------------------------------------------------------------------------

  static const primary = Color(0xFF1E88E5);
  static const onPrimary = Color(0xFFFFFFFF);

  static const primaryContainer = Color(0xFFD7E9FF);
  static const onPrimaryContainer = Color(0xFF002E62);

  static const secondary = Color(0xFF26A69A);
  static const onSecondary = Color(0xFFFFFFFF);

  static const secondaryContainer = Color(0xFFB8F0EA);
  static const onSecondaryContainer = Color(0xFF003732);

  // ---------------------------------------------------------------------------
  // ERROR
  // ---------------------------------------------------------------------------

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);

  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF410002);

  // ---------------------------------------------------------------------------
  // SUCCESS
  // ---------------------------------------------------------------------------

  static const success = Color(0xFF2E7D32);
  static const successContainer = Color(0xFFE8F5E9);

  // ---------------------------------------------------------------------------
  // WARNING
  // ---------------------------------------------------------------------------

  static const warning = Color(0xFFF57C00);
  static const warningContainer = Color(0xFFFFF3E0);

  // ---------------------------------------------------------------------------
  // INFO
  // ---------------------------------------------------------------------------

  static const info = Color(0xFF0288D1);
  static const infoContainer = Color(0xFFE1F5FE);

  // ---------------------------------------------------------------------------
  // SURFACES (Material Design 3)
  // ---------------------------------------------------------------------------

  static const surface = Color(0xFFFDFBFF);
  static const surfaceDim = Color(0xFFF2F4F8);
  static const surfaceBright = Color(0xFFFFFFFF);

  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF7F8FC);
  static const surfaceContainer = Color(0xFFF1F3F8);
  static const surfaceContainerHigh = Color(0xFFEBEEF4);
  static const surfaceContainerHighest = Color(0xFFE3E8EF);

  // ---------------------------------------------------------------------------
  // TEXT
  // ---------------------------------------------------------------------------

  static const onSurface = Color(0xFF1B1F23);
  static const onSurfaceVariant = Color(0xFF5D6673);

  static const textPrimary = onSurface;
  static const textSecondary = onSurfaceVariant;
  static const textDisabled = Color(0xFF9AA3B2);

  // ---------------------------------------------------------------------------
  // OUTLINE
  // ---------------------------------------------------------------------------

  static const outline = Color(0xFFB4BEC9);
  static const outlineVariant = Color(0xFFD6DEE8);

  // ---------------------------------------------------------------------------
  // BACKGROUND
  // ---------------------------------------------------------------------------

  static const background = surface;
  static const onBackground = onSurface;

  // ---------------------------------------------------------------------------
  // SHADOW / SCRIM
  // ---------------------------------------------------------------------------

  static const shadow = Color(0xFF000000);
  static const scrim = Color(0x66000000);

  // ---------------------------------------------------------------------------
  // INVERSE
  // ---------------------------------------------------------------------------

  static const inverseSurface = Color(0xFF2E3135);
  static const inverseOnSurface = Color(0xFFF1F1F1);
  static const inversePrimary = Color(0xFF9CCAFF);

  // ---------------------------------------------------------------------------
  // BADGES
  // ---------------------------------------------------------------------------

  static Color badgeForeground(String state) {
    switch (state) {
      case 'EN_ATTENTE':
        return warning;

      case 'VALIDE':
        return info;

      case 'EN_COURS':
      case 'ACTIVE':
        return success;

      case 'RENDU':
        return textSecondary;

      case 'EXPIRE':
      case 'EXPIREE':
      case 'REFUSE':
      case 'REVOQUEE':
        return error;

      default:
        return textSecondary;
    }
  }

  static Color badgeBackground(String state) {
    switch (state) {
      case 'EN_ATTENTE':
        return warningContainer;

      case 'VALIDE':
        return infoContainer;

      case 'EN_COURS':
      case 'ACTIVE':
        return successContainer;

      case 'RENDU':
        return surfaceContainer;

      case 'EXPIRE':
      case 'EXPIREE':
      case 'REFUSE':
      case 'REVOQUEE':
        return errorContainer;

      default:
        return surfaceContainer;
    }
  }
}