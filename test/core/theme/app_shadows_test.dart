import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/core/theme/app_shadows.dart';

void main() {
  group('AppShadows', () {
    test('subtle shadows are non-empty and defined properly', () {
      expect(AppShadows.sm.length, 1);
      expect(AppShadows.sm.first.blurRadius, 4.0);

      expect(AppShadows.md.length, 1);
      expect(AppShadows.md.first.blurRadius, 8.0);

      expect(AppShadows.lg.length, 1);
      expect(AppShadows.lg.first.blurRadius, 16.0);
    });

    test('component shadows alias or define appropriate BoxShadows', () {
      expect(AppShadows.card, AppShadows.md);
      expect(AppShadows.dialog, AppShadows.lg);

      expect(AppShadows.floating.length, 1);
      expect(AppShadows.floating.first.blurRadius, 12.0);

      expect(AppShadows.bottomSheet.length, 1);
      expect(AppShadows.bottomSheet.first.blurRadius, 20.0);
      expect(AppShadows.bottomSheet.first.offset, const Offset(0, -6));
    });
  });
}
