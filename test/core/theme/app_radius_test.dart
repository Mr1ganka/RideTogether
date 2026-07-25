import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_radius.dart';

void main() {
  group('AppRadius', () {
    test('standard radius tokens increase sequentially', () {
      expect(AppRadius.sm, 8.0);
      expect(AppRadius.md, 12.0);
      expect(AppRadius.lg, 16.0);
      expect(AppRadius.xl, 24.0);
      expect(AppRadius.xxl, 32.0);

      expect(AppRadius.sm < AppRadius.md, isTrue);
      expect(AppRadius.md < AppRadius.lg, isTrue);
      expect(AppRadius.lg < AppRadius.xl, isTrue);
      expect(AppRadius.xl < AppRadius.xxl, isTrue);
    });

    test('special shape radius tokens match definitions', () {
      expect(AppRadius.circular, 999.0);
      expect(AppRadius.none, 0.0);
    });

    test('component specific radius tokens match base tokens', () {
      expect(AppRadius.button, AppRadius.md);
      expect(AppRadius.card, AppRadius.lg);
      expect(AppRadius.input, AppRadius.md);
      expect(AppRadius.bottomSheet, AppRadius.xl);
      expect(AppRadius.dialog, AppRadius.lg);
      expect(AppRadius.fab, AppRadius.circular);
    });
  });
}
