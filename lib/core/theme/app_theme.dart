import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

/// Application theme configuration for RideTogether.
///
/// This class combines all design system components into Flutter ThemeData.
///
/// Design tokens live separately:
/// - AppColors
/// - AppTextStyles
/// - AppRadius
/// - AppShadows
///
/// This file is responsible only for composition.
abstract final class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------

  static ThemeData get lightTheme {
    return _theme(
      brightness: Brightness.light,
      background: AppLightColors.background,
      surface: AppLightColors.surface,
      surfaceVariant: AppLightColors.surfaceVariant,
      textPrimary: AppLightColors.textPrimary,
      divider: AppLightColors.divider,
    );
  }

  // ---------------------------------------------------------------------------
  // Dark Theme
  // ---------------------------------------------------------------------------

  static ThemeData get darkTheme {
    return _theme(
      brightness: Brightness.dark,
      background: AppColors.background,
      surface: AppColors.surface,
      surfaceVariant: AppColors.surfaceVariant,
      textPrimary: AppColors.textPrimary,
      divider: AppColors.divider,
    );
  }

  static ThemeData _theme({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceVariant,
    required Color textPrimary,
    required Color divider,
  }) {
    return ThemeData(
      useMaterial3: true,

      // -----------------------------------------------------------------------
      // Color System
      // -----------------------------------------------------------------------
      brightness: brightness,

      scaffoldBackgroundColor: background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: surface,
        error: AppColors.danger,
      ),

      // -----------------------------------------------------------------------
      // Typography
      // -----------------------------------------------------------------------
      textTheme: AppTextStyles.textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),

      // -----------------------------------------------------------------------
      // Component Themes
      // -----------------------------------------------------------------------

      // Cards
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
        ),
      ),

      // Bottom Sheets
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.bottomSheet),
          ),
        ),
      ),

      // Floating Action Buttons
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.fab),
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),

      // Divider
      dividerTheme: DividerThemeData(color: divider),

      // Snackbars
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceVariant,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),

      // AppBar / Navigation Bar
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: textPrimary),
        iconTheme: IconThemeData(color: textPrimary),
        actionsIconTheme: IconThemeData(color: textPrimary),
      ),
    );
  }
}
