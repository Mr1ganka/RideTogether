import 'geo_point.dart';

class CameraPosition {
  final GeoPoint target;
  final double zoom;

  /// Clockwise rotation in degrees.
  final double bearing;

  /// Camera tilt in degrees.
  final double tilt;

  const CameraPosition({
    required this.target,
    this.zoom = 15,
    this.bearing = 0,
    this.tilt = 0,
  });

  CameraPosition copyWith({
    GeoPoint? target,
    double? zoom,
    double? bearing,
    double? tilt,
  }) {
    return CameraPosition(
      target: target ?? this.target,
      zoom: zoom ?? this.zoom,
      bearing: bearing ?? this.bearing,
      tilt: tilt ?? this.tilt,
    );
  }
}
