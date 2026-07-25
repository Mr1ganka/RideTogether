import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_together/features/location/data/mapper/position_mapper.dart';

void main() {
  group('PositionMapper', () {
    test('maps Geolocator Position to PositionEntity', () {
      final now = DateTime.now();
      final geolocatorPosition = Position(
        latitude: 12.34,
        longitude: 56.78,
        timestamp: now,
        accuracy: 4.5,
        altitude: 100.0,
        heading: 45.0,
        speed: 12.0,
        speedAccuracy: 0.5,
        altitudeAccuracy: 1.0,
        headingAccuracy: 2.0,
      );

      final entity = PositionMapper.toEntity(geolocatorPosition);

      expect(entity.latitude, 12.34);
      expect(entity.longitude, 56.78);
      expect(entity.accuracy, 4.5);
      expect(entity.altitude, 100.0);
      expect(entity.heading, 45.0);
      expect(entity.speed, 12.0);
      expect(entity.timestamp, now);
    });
  });
}
