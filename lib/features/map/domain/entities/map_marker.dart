import 'geo_point.dart';

class MapMarker {
  final String id;
  final GeoPoint position;
  final String? label;
  final bool isLeader;

  const MapMarker({
    required this.id,
    required this.position,
    this.label,
    this.isLeader = false,
  });
}
