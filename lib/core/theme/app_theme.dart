import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_sizing.dart';
import 'app_typography.dart';

/// Single source of theme. Update design tokens in app_*.dart files;
/// this file composes them into [ThemeData] for light (and optionally dark).
abstract final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
      ),
      scaffoldBackgroundColor: AppColors.surface,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: AppColors.onSurface,
          fontSize: AppSizing.appBarTitleSize,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.card),
        color: AppColors.surfaceContainerLow,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizing.buttonPaddingH,
            vertical: AppSizing.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
          elevation: 0,
          textStyle: AppTypography.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizing.buttonPaddingH,
            vertical: AppSizing.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
          textStyle: AppTypography.labelLarge,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
      ),
    );
  }

  /// Optional: add dark theme when Figma DS provides dark tokens.
  // static ThemeData get dark => ...
}
