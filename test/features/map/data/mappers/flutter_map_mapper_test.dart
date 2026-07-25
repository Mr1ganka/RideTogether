import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:ride_together/features/map/data/mappers/flutter_map_mapper.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';

void main() {
  group('FlutterMapMapper', () {
    test('converts GeoPoint to LatLng', () {
      const geoPoint = GeoPoint(latitude: 37.7749, longitude: -122.4194);
      final latLng = geoPoint.toFlutterMapLatLng();

      expect(latLng.latitude, 37.7749);
      expect(latLng.longitude, -122.4194);
    });

    test('converts LatLng to GeoPoint', () {
      final latLng = LatLng(12.9716, 77.5946);
      final geoPoint = latLng.toGeoPoint();

      expect(geoPoint.latitude, 12.9716);
      expect(geoPoint.longitude, 77.5946);
    });
  });
}
