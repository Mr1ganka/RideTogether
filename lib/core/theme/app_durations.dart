/// Defines animation durations used throughout RideTogether.
///
/// This class contains only duration values.
/// It does not depend on colors, typography, widgets, or themes.
///
/// All animations should use these values instead of hardcoded durations.
abstract final class AppDurations {
  AppDurations._();

  // ---------------------------------------------------------------------------
  // Animation Speeds
  // ---------------------------------------------------------------------------

  /// Very fast interactions.
  ///
  /// Used for:
  /// - Button feedback
  /// - Icon changes
  /// - Small UI responses
  static const Duration instant = Duration(milliseconds: 100);

  /// Fast animations.
  ///
  /// Used for:
  /// - Micro interactions
  /// - Toggle changes
  /// - Small movements
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard application animation speed.
  ///
  /// Used for:
  /// - Cards
  /// - Bottom sheets
  /// - Common transitions
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow animations.
  ///
  /// Used for:
  /// - Larger transitions
  /// - Important visual changes
  static const Duration slow = Duration(milliseconds: 500);

  /// Very slow animations.
  ///
  /// Used rarely:
  /// - Splash animations
  /// - Special effects
  static const Duration verySlow = Duration(milliseconds: 800);

  // ---------------------------------------------------------------------------
  // Feature Specific Durations
  // ---------------------------------------------------------------------------

  /// Map marker animation duration.
  ///
  /// Used when rider positions update.
  static const Duration markerMovement = Duration(milliseconds: 500);

  /// Bottom sheet movement duration.
  static const Duration bottomSheet = Duration(milliseconds: 300);

  /// Notification animation duration.
  static const Duration notification = Duration(milliseconds: 250);

  /// Route update animation duration.
  static const Duration routeUpdate = Duration(milliseconds: 500);

  /// Bottom nav auto-hide delay.
  static const Duration autoHideNav = Duration(seconds: 3);

  /// Top update banner auto-minimize delay.
  static const Duration autoMinimizeBanner = Duration(seconds: 3);

  /// Active ride panel dropdown auto-collapse delay.
  static const Duration autoCollapsePanel = Duration(seconds: 3);
}
