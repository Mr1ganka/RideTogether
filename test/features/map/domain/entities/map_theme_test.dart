import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/map_theme.dart';

void main() {
  group('MapTheme', () {
    test('contains light and dark modes', () {
      expect(MapTheme.values, containsAll([MapTheme.light, MapTheme.dark]));
    });
  });
}
