import 'package:geolocator/geolocator.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../../data/mapper/position_mapper.dart';

class GeolocatorLocationRepository implements LocationRepository {
  @override
  Future<PositionEntity?> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    return PositionMapper.toEntity(position);
  }

  @override
  Stream<PositionEntity> getPositionStream() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map(PositionMapper.toEntity);
  }

  @override
  Future<PermissionStatusEntity> checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return PermissionStatusEntity.serviceDisabled;
    }

    final permission = await Geolocator.checkPermission();

    return _mapPermission(permission);
  }

  @override
  Future<PermissionStatusEntity> requestPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return PermissionStatusEntity.serviceDisabled;
    }

    final permission = await Geolocator.requestPermission();

    return _mapPermission(permission);
  }

  PermissionStatusEntity _mapPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return PermissionStatusEntity.granted;

      case LocationPermission.denied:
        return PermissionStatusEntity.denied;

      case LocationPermission.deniedForever:
        return PermissionStatusEntity.permanentlyDenied;

      case LocationPermission.unableToDetermine:
        return PermissionStatusEntity.unknown;
    }
  }
}
