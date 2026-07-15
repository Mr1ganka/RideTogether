import 'geo_point.dart';

class MapBounds {
  final GeoPoint northEast;
  final GeoPoint southWest;

  const MapBounds({
    required this.northEast,
    required this.southWest,
  });
}