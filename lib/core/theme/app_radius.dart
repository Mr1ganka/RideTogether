/// Defines the border radius system for RideTogether.
///
/// This class contains only radius values.
/// It does not depend on colors, typography, widgets, or themes.
///
/// All rounded corners throughout the application should use these values
/// instead of hardcoded numbers.
abstract final class AppRadius {
  AppRadius._();

  // ---------------------------------------------------------------------------
  // Standard Radius Values
  // ---------------------------------------------------------------------------

  /// Small radius.
  ///
  /// Used for:
  /// - Small chips
  /// - Compact buttons
  /// - Tags
  static const double sm = 8.0;

  /// Medium radius.
  ///
  /// Used for:
  /// - Input fields
  /// - Small cards
  /// - Buttons
  static const double md = 12.0;

  /// Large radius.
  ///
  /// Used for:
  /// - Main cards
  /// - Ride information cards
  /// - Dialogs
  static const double lg = 16.0;

  /// Extra large radius.
  ///
  /// Used for:
  /// - Bottom sheets
  /// - Large containers
  static const double xl = 24.0;

  /// Extra extra large radius.
  ///
  /// Used for:
  /// - Hero sections
  /// - Large floating surfaces
  static const double xxl = 32.0;

  // ---------------------------------------------------------------------------
  // Special Shapes
  // ---------------------------------------------------------------------------

  /// Fully circular radius.
  ///
  /// Used for:
  /// - Avatars
  /// - Floating action buttons
  /// - Circular controls
  static const double circular = 999.0;

  /// Zero radius.
  ///
  /// Used when sharp corners are required.
  static const double none = 0.0;

  // ---------------------------------------------------------------------------
  // Component Specific Radius
  // ---------------------------------------------------------------------------

  /// Button radius.
  static const double button = md;

  /// Card radius.
  static const double card = lg;

  /// Input field radius.
  static const double input = md;

  /// Bottom sheet radius.
  static const double bottomSheet = xl;

  /// Dialog radius.
  static const double dialog = lg;

  /// Floating action button radius.
  static const double fab = circular;
}
