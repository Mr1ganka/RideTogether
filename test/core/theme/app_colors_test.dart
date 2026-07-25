import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('brand colors are defined correctly', () {
      expect(AppColors.primary, const Color(0xFF4169E1));
      expect(AppColors.accent, const Color(0xFFFF8C42));
    });

    test('background and surface colors are defined correctly', () {
      expect(AppColors.background, const Color(0xFF121212));
      expect(AppColors.surface, const Color(0xFF1E1E1E));
      expect(AppColors.surfaceVariant, const Color(0xFF2A2A2A));
    });

    test('text colors are defined correctly', () {
      expect(AppColors.textPrimary, const Color(0xFFFFFFFF));
      expect(AppColors.textSecondary, const Color(0xFFB3B3B3));
      expect(AppColors.textDisabled, const Color(0xFF757575));
    });

    test('status colors match expected semantic colors', () {
      expect(AppColors.success, const Color(0xFF4CAF50));
      expect(AppColors.warning, const Color(0xFFFFC107));
      expect(AppColors.danger, const Color(0xFFE53935));
      expect(AppColors.info, const Color(0xFF29B6F6));
    });

    test('rider status mappings use correct semantic colors', () {
      expect(AppColors.riderMoving, AppColors.success);
      expect(AppColors.riderStopped, AppColors.warning);
      expect(AppColors.riderOffline, AppColors.textDisabled);
      expect(AppColors.riderEmergency, AppColors.danger);
    });

    test('map marker colors use correct tokens', () {
      expect(AppColors.leaderMarker, AppColors.primary);
      expect(AppColors.participantMarker, AppColors.accent);
      expect(AppColors.checkpointMarker, AppColors.success);
      expect(AppColors.hazardMarker, AppColors.danger);
    });

    test('direction cone values match design tokens', () {
      expect(AppColors.directionConeBeam, const Color(0xFF4285F4));
      expect(AppColors.directionConeAlphaStrong, 0.45);
      expect(AppColors.directionConeAlphaMid, 0.18);
      expect(AppColors.directionConeAlphaFade, 0.0);
      expect(AppColors.directionConeBlur, 12.0);
      expect(AppColors.directionConeSize, 80.0);
    });

    test('miscellaneous colors are standard Flutter colors', () {
      expect(AppColors.white, Colors.white);
      expect(AppColors.black, Colors.black);
      expect(AppColors.transparent, Colors.transparent);
    });
  });

  group('AppLightColors', () {
    test('light colors are defined correctly', () {
      expect(AppLightColors.background, const Color(0xFFF8F9FC));
      expect(AppLightColors.surface, const Color(0xFFFFFFFF));
      expect(AppLightColors.surfaceVariant, const Color(0xFFE9EDF5));
      expect(AppLightColors.textPrimary, const Color(0xFF1A1C20));
      expect(AppLightColors.textSecondary, const Color(0xFF5D626C));
      expect(AppLightColors.textDisabled, const Color(0xFF9196A0));
      expect(AppLightColors.border, const Color(0xFFD7DCE5));
      expect(AppLightColors.divider, const Color(0xFFE1E5EC));
    });
  });
}
