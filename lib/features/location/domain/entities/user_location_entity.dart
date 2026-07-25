class UserLocationEntity {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? heading;
  final double? speed;
  final double? altitude;
  final DateTime timestamp;

  const UserLocationEntity({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.heading,
    this.speed,
    this.altitude,
    required this.timestamp,
  });

  UserLocationEntity copyWith({
    double? latitude,
    double? longitude,
    double? accuracy,
    double? heading,
    double? speed,
    double? altitude,
    DateTime? timestamp,
  }) {
    return UserLocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      altitude: altitude ?? this.altitude,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
