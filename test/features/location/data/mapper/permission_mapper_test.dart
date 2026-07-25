import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_together/features/location/data/mapper/permission_mapper.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';

void main() {
  group('PermissionMapper', () {
    test('maps LocationPermission.always to granted', () {
      expect(
        PermissionMapper.toEntity(LocationPermission.always),
        PermissionStatusEntity.granted,
      );
    });

    test('maps LocationPermission.whileInUse to granted', () {
      expect(
        PermissionMapper.toEntity(LocationPermission.whileInUse),
        PermissionStatusEntity.granted,
      );
    });

    test('maps LocationPermission.denied to denied', () {
      expect(
        PermissionMapper.toEntity(LocationPermission.denied),
        PermissionStatusEntity.denied,
      );
    });

    test('maps LocationPermission.deniedForever to permanentlyDenied', () {
      expect(
        PermissionMapper.toEntity(LocationPermission.deniedForever),
        PermissionStatusEntity.permanentlyDenied,
      );
    });

    test('maps LocationPermission.unableToDetermine to unknown', () {
      expect(
        PermissionMapper.toEntity(LocationPermission.unableToDetermine),
        PermissionStatusEntity.unknown,
      );
    });
  });
}
