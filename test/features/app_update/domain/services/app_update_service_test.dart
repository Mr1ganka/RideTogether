import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/app_update/domain/services/app_update_service.dart';

void main() {
  group('AppUpdateService', () {
    late AppUpdateService service;

    setUp(() {
      service = AppUpdateService();
    });

    test('isVersionOutdated should correctly compare semantic versions', () {
      expect(service.isVersionOutdated('1.0.0', '1.0.1'), isTrue);
      expect(service.isVersionOutdated('1.0.0', '1.1.0'), isTrue);
      expect(service.isVersionOutdated('1.0.0', '2.0.0'), isTrue);

      expect(service.isVersionOutdated('1.0.1', '1.0.0'), isFalse);
      expect(service.isVersionOutdated('1.1.0', '1.0.0'), isFalse);
      expect(service.isVersionOutdated('1.0.0', '1.0.0'), isFalse);

      // Compare with build numbers
      expect(service.isVersionOutdated('1.0.0+1', '1.0.1+2'), isTrue);
      expect(service.isVersionOutdated('1.0.1+2', '1.0.1+2'), isFalse);
    });
  });
}
