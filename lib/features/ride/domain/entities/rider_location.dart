class RiderLocation {
  final String userId;
  final double latitude;
  final double longitude;
  final double? heading;
  final double? speed;
  final DateTime updatedAt;

  const RiderLocation({
    required this.userId,
    required this.latitude,
    required this.longitude,
    this.heading,
    this.speed,
    required this.updatedAt,
  });

  bool get isMoving => speed != null && speed! > 1.0;

  RiderLocation copyWith({
    String? userId,
    double? latitude,
    double? longitude,
    double? heading,
    double? speed,
    DateTime? updatedAt,
  }) {
    return RiderLocation(
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
