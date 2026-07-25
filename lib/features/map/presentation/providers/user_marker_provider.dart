import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/location/domain/entities/position_entity.dart';
import 'package:ride_together/features/location/presentation/providers/current_posisiton_provider.dart';

import '../../domain/entities/geo_point.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/user_location_marker.dart';

final userMarkerProvider = Provider<MapMarker?>((ref) {
  final position = ref.watch(currentPositionProvider).value;

  if (position == null) {
    return null;
  }

  return MapMarker(
    id: 'current_user',
    position: GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    ),
  );
});

class UserLocationMarkerNotifier extends Notifier<UserLocationMarker?> {
  PositionEntity? _lastPosition;
  double _heading = 0.0;

  @override
  UserLocationMarker? build() {
    final positionAsync = ref.watch(currentPositionProvider);
    final position = positionAsync.value;

    if (position == null) {
      return null;
    }

    if (position.heading != null && position.heading! > 0) {
      _heading = position.heading!;
    } else if (_lastPosition != null &&
        (position.latitude != _lastPosition!.latitude ||
            position.longitude != _lastPosition!.longitude)) {
      final bearing = Geolocator.bearingBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        position.latitude,
        position.longitude,
      );
      if (bearing != 0) {
        _heading = (bearing + 360) % 360;
      }
    }

    _lastPosition = position;

    return UserLocationMarker(
      id: 'current_user',
      position: GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      heading: _heading,
      accuracy: position.accuracy,
      speed: position.speed,
      timestamp: position.timestamp,
    );
  }
}

final userLocationMarkerProvider =
    NotifierProvider<UserLocationMarkerNotifier, UserLocationMarker?>(
  UserLocationMarkerNotifier.new,
);

