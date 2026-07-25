import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/map_mode.dart';
import 'package:ride_together/features/map/domain/entities/map_theme.dart';
import 'package:ride_together/features/map/presentation/providers/map_controller_provider.dart';
import 'package:ride_together/features/map/presentation/providers/map_engine_provider.dart';
import 'package:ride_together/features/map/presentation/providers/map_mode_provider.dart';
import 'package:ride_together/features/map/presentation/providers/map_theme_provider.dart';
import 'package:ride_together/features/map/presentation/providers/user_marker_provider.dart';

void main() {
  group('Map Providers', () {
    test('mapModeProvider defaults to idle and updates mode', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(mapModeProvider), MapMode.idle);

      container.read(mapModeProvider.notifier).state = MapMode.activeRide;
      expect(container.read(mapModeProvider), MapMode.activeRide);
    });

    test('mapThemeProvider provides default MapTheme.light', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(mapThemeProvider), MapTheme.light);
    });

    test('mapControllerProvider creates MapController instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(mapControllerProvider);
      expect(controller, isNotNull);
    });

    test('mapEngineProvider provides MapEngine instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(mapEngineProvider);
      expect(engine, isNotNull);
    });

    test(
      'userMarkerProvider returns null when position is loading or null',
      () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final marker = container.read(userMarkerProvider);
        expect(marker, isNull);
      },
    );
  });
}
