import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the typography system for RideTogether.
///
/// This class contains only typography definitions:
/// - Font family
/// - Font size
/// - Font weight
/// - Letter spacing
///
/// Colors are intentionally not defined here.
/// Colors are applied through AppTheme.
abstract final class AppTextStyles {
  AppTextStyles._();

  // ---------------------------------------------------------------------------
  // Font Family
  // ---------------------------------------------------------------------------

  static final String fontFamily = GoogleFonts.inter().fontFamily!;

  // ---------------------------------------------------------------------------
  // Display Styles
  // ---------------------------------------------------------------------------

  static final TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  static final TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 45,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle displaySmall = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  // ---------------------------------------------------------------------------
  // Headline Styles
  // ---------------------------------------------------------------------------

  static final TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // ---------------------------------------------------------------------------
  // Title Styles
  // ---------------------------------------------------------------------------

  static final TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static final TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // ---------------------------------------------------------------------------
  // Body Styles
  // ---------------------------------------------------------------------------

  static final TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // ---------------------------------------------------------------------------
  // Label Styles
  // ---------------------------------------------------------------------------

  static final TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static final TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static final TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // ---------------------------------------------------------------------------
  // Complete Text Theme
  // ---------------------------------------------------------------------------

  static final TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}