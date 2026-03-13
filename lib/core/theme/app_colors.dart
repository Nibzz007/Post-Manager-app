import 'package:flutter/material.dart';

/// Semantic color tokens. Map Figma DS color variables here for easy updates.
abstract final class AppColors {
  AppColors._();

  // --- Brand / Primary ---
  static const Color primary = Color(0xFF5E3A8C);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // --- Surface & Background ---
  static const Color surface = Color(0xFFF8F7FA);
  static const Color surfaceContainerLow = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFE7E0EC);

  // --- Semantic ---
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57C00);

  // --- Overlay / Scrim ---
  static const Color scrim = Color(0x80000000);
}
