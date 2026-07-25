import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/map_bounds.dart';

void main() {
  group('MapBounds', () {
    test('holds northEast and southWest bounds', () {
      const ne = GeoPoint(latitude: 40.0, longitude: -70.0);
      const sw = GeoPoint(latitude: 30.0, longitude: -80.0);

      const bounds = MapBounds(northEast: ne, southWest: sw);
      expect(bounds.northEast, ne);
      expect(bounds.southWest, sw);
    });
  });
}
