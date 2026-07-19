import 'geo_point.dart';

class UserLocationMarker {
  final String id;
  final GeoPoint position;
  final double? accuracy;
  final double? heading;
  final double? speed;
  final DateTime timestamp;

  const UserLocationMarker({
    required this.id,
    required this.position,
    this.accuracy,
    this.heading,
    this.speed,
    required this.timestamp,
  });

  /// Returns true if the user is moving.
  /// A speed greater than ~1 m/s (~3.6 km/h) is considered moving (brisk walk).
  bool get isMoving => (speed ?? 0) > 1.0;

  UserLocationMarker copyWith({
    String? id,
    GeoPoint? position,
    double? accuracy,
    double? heading,
    double? speed,
    DateTime? timestamp,
  }) {
    return UserLocationMarker(
      id: id ?? this.id,
      position: position ?? this.position,
      accuracy: accuracy ?? this.accuracy,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
