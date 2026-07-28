import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_together/core/theme/app_colors.dart';
import 'package:ride_together/core/theme/app_theme.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  group('AppTheme', () {
    testWidgets('configures Material 3 light and dark themes', (tester) async {
      final lightTheme = AppTheme.lightTheme;
      final darkTheme = AppTheme.darkTheme;

      expect(lightTheme.useMaterial3, isTrue);
      expect(lightTheme.brightness, Brightness.light);
      expect(darkTheme.brightness, Brightness.dark);
      expect(lightTheme.colorScheme.primary, AppColors.primary);
      expect(darkTheme.colorScheme.primary, AppColors.primary);
      expect(lightTheme.scaffoldBackgroundColor, AppLightColors.background);
      expect(darkTheme.scaffoldBackgroundColor, AppColors.background);
    });

    testWidgets('configures component themes for darkTheme', (tester) async {
      final theme = AppTheme.darkTheme;

      expect(theme.cardTheme.color, AppColors.surface);
      expect(theme.dialogTheme.backgroundColor, AppColors.surface);
      expect(theme.bottomSheetTheme.backgroundColor, AppColors.surface);
      expect(
        theme.floatingActionButtonTheme.backgroundColor,
        AppColors.primary,
      );
      expect(
        theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
        AppColors.primary,
      );
      expect(theme.appBarTheme.backgroundColor, AppColors.surface);
    });
  });
}
