import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';

void main() {
  group('GeoPoint', () {
    test('equality and hashCode work properly', () {
      const p1 = GeoPoint(latitude: 10.0, longitude: 20.0);
      const p2 = GeoPoint(latitude: 10.0, longitude: 20.0);
      const p3 = GeoPoint(latitude: 10.0, longitude: 25.0);

      expect(p1, equals(p2));
      expect(p1.hashCode, equals(p2.hashCode));
      expect(p1, isNot(equals(p3)));
    });

    test('toString formats coordinates cleanly', () {
      const point = GeoPoint(latitude: 12.34, longitude: 56.78);
      expect(point.toString(), 'GeoPoint(12.34, 56.78)');
    });
  });
}
