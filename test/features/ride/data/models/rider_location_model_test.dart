import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/ride/data/models/rider_location_model.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';

void main() {
  group('RiderLocationModel Tests', () {
    test('toMap and fromMap serialize and deserialize correctly', () {
      final now = DateTime.parse('2026-07-31T03:00:00.000Z');
      final model = RiderLocationModel(
        userId: 'user-1',
        latitude: 12.9716,
        longitude: 77.5946,
        heading: 180.0,
        speed: 12.4,
        updatedAt: now,
      );

      final map = model.toMap();
      final restored = RiderLocationModel.fromMap(map, 'user-1');

      expect(restored.userId, 'user-1');
      expect(restored.latitude, 12.9716);
      expect(restored.longitude, 77.5946);
      expect(restored.heading, 180.0);
      expect(restored.speed, 12.4);
      expect(restored.updatedAt, now);
    });

    test('fromEntity converts RiderLocation entity to model', () {
      final now = DateTime.now();
      final entity = RiderLocation(
        userId: 'user-2',
        latitude: 13.0827,
        longitude: 80.2707,
        heading: 45.0,
        speed: 8.0,
        updatedAt: now,
      );

      final model = RiderLocationModel.fromEntity(entity);

      expect(model.userId, 'user-2');
      expect(model.latitude, 13.0827);
      expect(model.longitude, 80.2707);
      expect(model.heading, 45.0);
      expect(model.speed, 8.0);
      expect(model.updatedAt, now);
    });
  });
}
