import 'package:latlong2/latlong.dart';

import '../../domain/entities/geo_point.dart';

extension GeoPointFlutterMapMapper on GeoPoint {
  LatLng toFlutterMapLatLng() {
    return LatLng(latitude, longitude);
  }
}

extension LatLngFlutterMapMapper on LatLng {
  GeoPoint toGeoPoint() {
    return GeoPoint(latitude: latitude, longitude: longitude);
  }
}
