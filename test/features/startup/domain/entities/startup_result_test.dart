import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';
import 'package:ride_together/features/startup/domain/entities/startup_result.dart';

void main() {
  group('StartupResult', () {
    test('StartupReady instantiation', () {
      const result = StartupReady();
      expect(result, isA<StartupResult>());
    });

    test('StartupLocationRequired retains permission status', () {
      const result = StartupLocationRequired(PermissionStatusEntity.denied);
      expect(result, isA<StartupResult>());
      expect(result.status, PermissionStatusEntity.denied);
    });
  });
}
