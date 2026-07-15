import 'package:geolocator/geolocator.dart';

import '../../domain/entities/permission_status_entity.dart';

class PermissionMapper {
  const PermissionMapper._();

  static PermissionStatusEntity toEntity(
    LocationPermission permission,
  ) {
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