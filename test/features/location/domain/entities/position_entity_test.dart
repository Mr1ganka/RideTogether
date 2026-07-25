import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/domain/entities/position_entity.dart';

void main() {
  group('PositionEntity', () {
    test('holds correct location and telemetry fields', () {
      final now = DateTime.now();
      final pos = PositionEntity(
        latitude: 37.7749,
        longitude: -122.4194,
        accuracy: 5.0,
        altitude: 10.0,
        heading: 180.0,
        speed: 15.5,
        timestamp: now,
      );

      expect(pos.latitude, 37.7749);
      expect(pos.longitude, -122.4194);
      expect(pos.accuracy, 5.0);
      expect(pos.altitude, 10.0);
      expect(pos.heading, 180.0);
      expect(pos.speed, 15.5);
      expect(pos.timestamp, now);
    });
  });
}
