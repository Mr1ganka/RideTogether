import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/profile/domain/mappers/rider_profile_mapper.dart';

void main() {
  group('RiderProfileMapper', () {
    test('maps AppUser to RiderProfile with display name', () {
      const user = AppUser(
        id: 'user-77',
        displayName: 'Ghost Rider',
        photoUrl: 'https://photo.url',
      );

      final profile = RiderProfileMapper.fromAppUser(user);

      expect(profile.id, 'user-77');
      expect(profile.displayName, 'Ghost Rider');
      expect(profile.photoUrl, 'https://photo.url');
      expect(profile.createdAt, isNotNull);
      expect(profile.updatedAt, isNotNull);
    });

    test('fallback to default name "Rider" if displayName is null', () {
      const user = AppUser(id: 'user-88');

      final profile = RiderProfileMapper.fromAppUser(user);

      expect(profile.id, 'user-88');
      expect(profile.displayName, 'Rider');
    });
  });
}
