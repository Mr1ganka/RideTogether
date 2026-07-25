import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/map_marker.dart';

void main() {
  group('MapMarker', () {
    test('holds id and position', () {
      const pos = GeoPoint(latitude: 1.0, longitude: 2.0);
      const marker = MapMarker(id: 'm1', position: pos);

      expect(marker.id, 'm1');
      expect(marker.position, pos);
    });
  });
}
