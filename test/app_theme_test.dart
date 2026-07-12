import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_colors.dart';
import 'package:ride_together/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('configures Material 3 light and dark themes', () {
      final lightTheme = AppTheme.lightTheme;
      final darkTheme = AppTheme.darkTheme;

      expect(lightTheme.useMaterial3, isTrue);
      expect(lightTheme.brightness, Brightness.light);
      expect(darkTheme.brightness, Brightness.dark);
      expect(lightTheme.colorScheme.primary, AppColors.primary);
      expect(darkTheme.colorScheme.primary, AppColors.primary);
    });
  });
}
