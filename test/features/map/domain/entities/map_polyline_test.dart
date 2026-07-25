import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/map_polyline.dart';

void main() {
  group('MapPolyline', () {
    test('holds id and points list', () {
      const points = [
        GeoPoint(latitude: 0, longitude: 0),
        GeoPoint(latitude: 1, longitude: 1),
      ];

      const polyline = MapPolyline(id: 'line-1', points: points);

      expect(polyline.id, 'line-1');
      expect(polyline.points, points);
      expect(polyline.points.length, 2);
    });
  });
}
