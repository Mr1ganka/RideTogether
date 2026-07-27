import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:ride_together/features/map/presentation/utils/map_animation_utils.dart';

void main() {
  group('MapAnimationUtils - Camera Edge Detection', () {
    test('isLatLngNearCameraEdge returns false when point is near map center', () {
      final camera = MapCamera(
        center: const LatLng(10.0, 20.0),
        zoom: 15.0,
        crs: const Epsg3857(),
        rotation: 0.0,
        nonRotatedSize: const Size(800.0, 600.0),
      );

      final centerPoint = camera.center;
      final isNearEdge = isLatLngNearCameraEdge(
        camera: camera,
        point: centerPoint,
      );

      expect(isNearEdge, isFalse);
    });

    test('isLatLngNearCameraEdge returns true when point is far out near the bounds edge', () {
      final camera = MapCamera(
        center: const LatLng(10.0, 20.0),
        zoom: 15.0,
        crs: const Epsg3857(),
        rotation: 0.0,
        nonRotatedSize: const Size(800.0, 600.0),
      );

      final bounds = camera.visibleBounds;
      final edgePoint = LatLng(bounds.north - 0.0001, camera.center.longitude);

      final isNearEdge = isLatLngNearCameraEdge(
        camera: camera,
        point: edgePoint,
      );

      expect(isNearEdge, isTrue);
    });
  });
}
