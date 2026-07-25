import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';

void main() {
  group('PermissionStatusEntity', () {
    test('enum contains expected values', () {
      expect(PermissionStatusEntity.values, containsAll([
        PermissionStatusEntity.unknown,
        PermissionStatusEntity.granted,
        PermissionStatusEntity.denied,
        PermissionStatusEntity.permanentlyDenied,
        PermissionStatusEntity.serviceDisabled,
      ]));
    });
  });
}
