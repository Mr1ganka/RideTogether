import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';

void main() {
  group('RiderProfile', () {
    test('retains all rider profile attributes', () {
      final now = DateTime.now();
      final profile = RiderProfile(
        id: 'rider-100',
        displayName: 'Speedy',
        photoUrl: 'https://avatar.png',
        createdAt: now,
        updatedAt: now,
      );

      expect(profile.id, 'rider-100');
      expect(profile.displayName, 'Speedy');
      expect(profile.photoUrl, 'https://avatar.png');
      expect(profile.createdAt, now);
      expect(profile.updatedAt, now);
    });
  });
}
