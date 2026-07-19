import 'package:geolocator/geolocator.dart';

import '../../domain/entities/position_entity.dart';

class PositionMapper {
  const PositionMapper._();

  static PositionEntity toEntity(Position position) {
    return PositionEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      timestamp: position.timestamp,
    );
  }
}
