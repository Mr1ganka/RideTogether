import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/domain/entities/user_location_entity.dart';

void main() {
  group('UserLocationEntity', () {
    test('holds location fields and supports copyWith', () {
      final now = DateTime.now();
      final entity = UserLocationEntity(
        latitude: 12.9716,
        longitude: 77.5946,
        accuracy: 10.0,
        heading: 90.0,
        speed: 5.0,
        altitude: 900.0,
        timestamp: now,
      );

      expect(entity.latitude, 12.9716);
      expect(entity.longitude, 77.5946);

      final updated = entity.copyWith(heading: 120.0, speed: 8.0);
      expect(updated.latitude, 12.9716);
      expect(updated.heading, 120.0);
      expect(updated.speed, 8.0);
      expect(updated.timestamp, now);
    });
  });
}
