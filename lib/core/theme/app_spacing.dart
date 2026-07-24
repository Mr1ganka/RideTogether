/// Defines the spacing system for RideTogether.
///
/// This class contains only spacing values.
/// It does not depend on colors, typography, widgets, or themes.
///
/// All UI spacing should use these values instead of hardcoded numbers.
abstract final class AppSpacing {
  AppSpacing._();

  // ---------------------------------------------------------------------------
  // Base Spacing Values
  // ---------------------------------------------------------------------------

  /// Extra extra small spacing.
  static const double xxs = 4.0;

  /// Extra small spacing.
  static const double xs = 8.0;

  /// Small spacing.
  static const double sm = 12.0;

  /// Medium spacing.
  static const double md = 16.0;

  /// Large spacing.
  static const double lg = 20.0;

  /// Extra large spacing.
  static const double xl = 24.0;

  /// Extra extra large spacing.
  static const double xxl = 32.0;

  /// Large section spacing.
  static const double xxxl = 40.0;

  // ---------------------------------------------------------------------------
  // Layout Spacing
  // ---------------------------------------------------------------------------

  /// Large screen section spacing.
  static const double section = 48.0;

  /// Major page separation spacing.
  static const double page = 64.0;

  /// Hero spacing.
  static const double hero = 80.0;

  // ---------------------------------------------------------------------------
  // Common Component Sizes
  // ---------------------------------------------------------------------------

  /// Default icon spacing.
  static const double icon = 24.0;

  /// Small icon spacing.
  static const double iconSmall = 16.0;

  /// Large icon spacing.
  static const double iconLarge = 32.0;

  /// Avatar spacing.
  static const double avatar = 48.0;

  /// Large avatar spacing.
  static const double avatarLarge = 64.0;

  // ---------------------------------------------------------------------------
  // Map Specific Spacing
  // ---------------------------------------------------------------------------

  /// Floating button distance from screen edges.
  static const double mapPadding = 16.0;

  /// Bottom sheet internal padding.
  static const double bottomSheetPadding = 20.0;

  // ---------------------------------------------------------------------------
  // Map Control Spacing
  // ---------------------------------------------------------------------------

  /// Extra bottom padding for the bottom nav bar.
  static const double bottomNavAir = 2.0;
}