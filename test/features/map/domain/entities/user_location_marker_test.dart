import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/user_location_marker.dart';

void main() {
  group('UserLocationMarker', () {
    test('isMoving returns true when speed > 1.0 m/s', () {
      final now = DateTime.now();
      final marker = UserLocationMarker(
        id: 'user-marker',
        position: const GeoPoint(latitude: 10.0, longitude: 20.0),
        speed: 2.5,
        timestamp: now,
      );

      expect(marker.isMoving, isTrue);
    });

    test('isMoving returns false when speed <= 1.0 m/s or null', () {
      final now = DateTime.now();
      final stoppedMarker = UserLocationMarker(
        id: 'user-marker',
        position: const GeoPoint(latitude: 10.0, longitude: 20.0),
        speed: 0.5,
        timestamp: now,
      );
      final nullSpeedMarker = UserLocationMarker(
        id: 'user-marker',
        position: const GeoPoint(latitude: 10.0, longitude: 20.0),
        speed: null,
        timestamp: now,
      );

      expect(stoppedMarker.isMoving, isFalse);
      expect(nullSpeedMarker.isMoving, isFalse);
    });

    test('copyWith updates fields', () {
      final now = DateTime.now();
      final marker = UserLocationMarker(
        id: 'user-marker',
        position: const GeoPoint(latitude: 10.0, longitude: 20.0),
        speed: 0.0,
        heading: 90.0,
        timestamp: now,
      );

      final updated = marker.copyWith(speed: 10.0, heading: 180.0);
      expect(updated.speed, 10.0);
      expect(updated.heading, 180.0);
      expect(updated.id, 'user-marker');
    });
  });
}
