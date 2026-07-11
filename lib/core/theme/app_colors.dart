import 'package:flutter/material.dart';

/// Central color palette for the RideTogether application.
///
/// This class contains only semantic color definitions.
/// It does not define where colors are used—that is the
/// responsibility of the application's ThemeData.
abstract final class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand Colors
  // ---------------------------------------------------------------------------

  /// Primary RideTogether blue.
  static const Color primary = Color(0xFF4169E1);

  /// Accent orange used for highlights and important actions.
  static const Color accent = Color(0xFFFF8C42);

  // ---------------------------------------------------------------------------
  // Background Colors
  // ---------------------------------------------------------------------------

  /// Default application background.
  static const Color background = Color(0xFF121212);

  /// Primary surface color for cards, sheets, and dialogs.
  static const Color surface = Color(0xFF1E1E1E);

  /// Elevated surface color.
  static const Color surfaceVariant = Color(0xFF2A2A2A);

  // ---------------------------------------------------------------------------
  // Text Colors
  // ---------------------------------------------------------------------------

  /// Primary text color.
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary text color.
  static const Color textSecondary = Color(0xFFB3B3B3);

  /// Disabled text color.
  static const Color textDisabled = Color(0xFF757575);

  // ---------------------------------------------------------------------------
  // Status Colors
  // ---------------------------------------------------------------------------

  /// Success state.
  static const Color success = Color(0xFF4CAF50);

  /// Warning state.
  static const Color warning = Color(0xFFFFC107);

  /// Error and danger state.
  static const Color danger = Color(0xFFE53935);

  /// Informational state.
  static const Color info = Color(0xFF29B6F6);

  // ---------------------------------------------------------------------------
  // Border & Divider
  // ---------------------------------------------------------------------------

  /// Standard border color.
  static const Color border = Color(0xFF3A3A3A);

  /// Divider color.
  static const Color divider = Color(0xFF2C2C2C);

  // ---------------------------------------------------------------------------
  // Ride Status Colors
  // ---------------------------------------------------------------------------

  /// Rider is currently moving.
  static const Color riderMoving = success;

  /// Rider has stopped.
  static const Color riderStopped = warning;

  /// Rider is offline.
  static const Color riderOffline = textDisabled;

  /// Rider is in an emergency state.
  static const Color riderEmergency = danger;

  // ---------------------------------------------------------------------------
  // Map Colors
  // ---------------------------------------------------------------------------

  /// Leader marker.
  static const Color leaderMarker = primary;

  /// Participant marker.
  static const Color participantMarker = accent;

  /// Checkpoint marker.
  static const Color checkpointMarker = success;

  /// Hazard marker.
  static const Color hazardMarker = danger;

  // ---------------------------------------------------------------------------
  // Miscellaneous
  // ---------------------------------------------------------------------------

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}

/// Semantic color palette used when the device is in light mode.
abstract final class AppLightColors {
  AppLightColors._();

  static const Color background = Color(0xFFF8F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE9EDF5);

  static const Color textPrimary = Color(0xFF1A1C20);
  static const Color textSecondary = Color(0xFF5D626C);
  static const Color textDisabled = Color(0xFF9196A0);

  static const Color border = Color(0xFFD7DCE5);
  static const Color divider = Color(0xFFE1E5EC);
}
