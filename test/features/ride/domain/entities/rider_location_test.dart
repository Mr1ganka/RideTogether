import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';

void main() {
  group('RiderLocation Entity Tests', () {
    test('isMoving returns true when speed > 1.0 m/s', () {
      final loc = RiderLocation(
        userId: 'user-1',
        latitude: 12.9716,
        longitude: 77.5946,
        speed: 5.5,
        updatedAt: DateTime.now(),
      );

      expect(loc.isMoving, isTrue);
    });

    test('isMoving returns false when speed <= 1.0 m/s or null', () {
      final locStopped = RiderLocation(
        userId: 'user-1',
        latitude: 12.9716,
        longitude: 77.5946,
        speed: 0.5,
        updatedAt: DateTime.now(),
      );

      final locNullSpeed = RiderLocation(
        userId: 'user-1',
        latitude: 12.9716,
        longitude: 77.5946,
        speed: null,
        updatedAt: DateTime.now(),
      );

      expect(locStopped.isMoving, isFalse);
      expect(locNullSpeed.isMoving, isFalse);
    });

    test('copyWith updates fields correctly', () {
      final original = RiderLocation(
        userId: 'user-1',
        latitude: 12.9716,
        longitude: 77.5946,
        heading: 90.0,
        speed: 10.0,
        updatedAt: DateTime.parse('2026-07-31T00:00:00Z'),
      );

      final updated = original.copyWith(latitude: 13.0000, speed: 15.0);

      expect(updated.userId, 'user-1');
      expect(updated.latitude, 13.0000);
      expect(updated.longitude, 77.5946);
      expect(updated.speed, 15.0);
    });
  });
}
