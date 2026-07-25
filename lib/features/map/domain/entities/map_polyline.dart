import 'geo_point.dart';

class MapPolyline {
  final String id;
  final List<GeoPoint> points;

  const MapPolyline({required this.id, required this.points});
}
