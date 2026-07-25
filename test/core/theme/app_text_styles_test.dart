import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_together/core/theme/app_text_styles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  group('AppTextStyles', () {
    testWidgets('textTheme is defined with expected font sizes', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      expect(AppTextStyles.displayLarge.fontSize, 57);
      expect(AppTextStyles.headlineLarge.fontSize, 32);
      expect(AppTextStyles.titleMedium.fontSize, 16);
      expect(AppTextStyles.bodyMedium.fontSize, 14);
      expect(AppTextStyles.labelSmall.fontSize, 11);
    });
  });
}
