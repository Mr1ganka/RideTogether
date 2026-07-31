import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/app_update/domain/models/app_version_info.dart';

void main() {
  group('AppVersionInfo', () {
    test('fromMap should parse Firestore data correctly', () {
      final map = {
        'latest_version': '1.0.1',
        'min_supported_version': '1.0.0',
        'build_number': 2,
        'download_url': 'https://github.com/test/app-release.apk',
        'release_notes': 'Test release notes',
        'update_type': 'optional',
        'sha256': 'test_hash',
      };

      final info = AppVersionInfo.fromMap(map);

      expect(info.latestVersion, equals('1.0.1'));
      expect(info.minSupportedVersion, equals('1.0.0'));
      expect(info.buildNumber, equals(2));
      expect(info.downloadUrl, equals('https://github.com/test/app-release.apk'));
      expect(info.releaseNotes, equals('Test release notes'));
      expect(info.updateType, equals('optional'));
      expect(info.sha256, equals('test_hash'));
    });

    test('fromMap should fallback to default values when map is empty', () {
      final info = AppVersionInfo.fromMap({});

      expect(info.latestVersion, equals('1.0.0'));
      expect(info.minSupportedVersion, equals('1.0.0'));
      expect(info.buildNumber, equals(1));
      expect(info.downloadUrl, equals(''));
      expect(info.updateType, equals('optional'));
    });
  });
}
