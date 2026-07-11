import 'package:flutter/material.dart';

/// Defines the shadow system for RideTogether.
///
/// This class contains reusable shadow definitions.
/// It does not depend on colors, typography, widgets, or themes.
///
/// Shadows should be subtle because RideTogether uses a dark-first UI.
abstract final class AppShadows {
  AppShadows._();

  // ---------------------------------------------------------------------------
  // Subtle Shadows
  // ---------------------------------------------------------------------------

  /// Small elevation shadow.
  ///
  /// Used for:
  /// - Small cards
  /// - Chips
  /// - Compact surfaces
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Medium elevation shadow.
  ///
  /// Used for:
  /// - Cards
  /// - Floating elements
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  /// Large elevation shadow.
  ///
  /// Used for:
  /// - Dialogs
  /// - Bottom sheets
  /// - Large floating surfaces
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Component Shadows
  // ---------------------------------------------------------------------------

  /// Card shadow.
  static const List<BoxShadow> card = md;

  /// Floating action button shadow.
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Colors.black54,
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  /// Bottom sheet shadow.
  static const List<BoxShadow> bottomSheet = [
    BoxShadow(
      color: Colors.black54,
      blurRadius: 20,
      offset: Offset(0, -6),
    ),
  ];

  /// Dialog shadow.
  static const List<BoxShadow> dialog = lg;
}