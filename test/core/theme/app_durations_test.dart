import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_durations.dart';

void main() {
  group('AppDurations', () {
    test('animation speed tokens are correctly ordered', () {
      expect(AppDurations.instant, const Duration(milliseconds: 100));
      expect(AppDurations.fast, const Duration(milliseconds: 150));
      expect(AppDurations.normal, const Duration(milliseconds: 300));
      expect(AppDurations.slow, const Duration(milliseconds: 500));
      expect(AppDurations.verySlow, const Duration(milliseconds: 800));

      expect(AppDurations.instant < AppDurations.fast, isTrue);
      expect(AppDurations.fast < AppDurations.normal, isTrue);
      expect(AppDurations.normal < AppDurations.slow, isTrue);
      expect(AppDurations.slow < AppDurations.verySlow, isTrue);
    });

    test('feature specific duration tokens are correct', () {
      expect(AppDurations.markerMovement, const Duration(milliseconds: 500));
      expect(AppDurations.bottomSheet, const Duration(milliseconds: 300));
      expect(AppDurations.notification, const Duration(milliseconds: 250));
      expect(AppDurations.routeUpdate, const Duration(milliseconds: 500));
      expect(AppDurations.autoHideNav, const Duration(seconds: 3));
    });
  });
}
