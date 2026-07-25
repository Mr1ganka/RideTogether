import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('base spacing tokens are in ascending order', () {
      expect(AppSpacing.xxs, 4.0);
      expect(AppSpacing.xs, 8.0);
      expect(AppSpacing.sm, 12.0);
      expect(AppSpacing.md, 16.0);
      expect(AppSpacing.lg, 20.0);
      expect(AppSpacing.xl, 24.0);
      expect(AppSpacing.xxl, 32.0);
      expect(AppSpacing.xxxl, 40.0);

      expect(AppSpacing.xxs < AppSpacing.xs, isTrue);
      expect(AppSpacing.xs < AppSpacing.sm, isTrue);
      expect(AppSpacing.sm < AppSpacing.md, isTrue);
      expect(AppSpacing.md < AppSpacing.lg, isTrue);
      expect(AppSpacing.lg < AppSpacing.xl, isTrue);
      expect(AppSpacing.xl < AppSpacing.xxl, isTrue);
      expect(AppSpacing.xxl < AppSpacing.xxxl, isTrue);
    });

    test('layout spacing tokens are defined properly', () {
      expect(AppSpacing.section, 48.0);
      expect(AppSpacing.page, 64.0);
      expect(AppSpacing.hero, 80.0);
    });

    test('component and map specific spacing tokens are correct', () {
      expect(AppSpacing.icon, 24.0);
      expect(AppSpacing.iconSmall, 16.0);
      expect(AppSpacing.iconLarge, 32.0);
      expect(AppSpacing.avatar, 48.0);
      expect(AppSpacing.avatarLarge, 64.0);
      expect(AppSpacing.mapPadding, 16.0);
      expect(AppSpacing.bottomSheetPadding, 20.0);
      expect(AppSpacing.bottomNavAir, 2.0);
    });
  });
}
