import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/camera_position.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';

void main() {
  group('CameraPosition', () {
    test('creates CameraPosition with defaults and copyWith', () {
      const target = GeoPoint(latitude: 40.7128, longitude: -74.0060);
      const camera = CameraPosition(target: target);

      expect(camera.target, target);
      expect(camera.zoom, 15);
      expect(camera.bearing, 0);
      expect(camera.tilt, 0);

      final updated = camera.copyWith(zoom: 18, bearing: 45);
      expect(updated.zoom, 18);
      expect(updated.bearing, 45);
      expect(updated.target, target);
    });
  });
}
