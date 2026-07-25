import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/data/constants/map_constants.dart';

void main() {
  group('MapConstants', () {
    test('contains expected tile URLs and user agent', () {
      expect(MapConstants.osmTileUrl, contains('openstreetmap.org'));
      expect(MapConstants.darkTileUrl, contains('cartocdn.com'));
      expect(MapConstants.darkSubdomains, equals(['a', 'b', 'c', 'd']));
      expect(MapConstants.userAgent, 'com.ridetogether.app');
    });
  });
}
