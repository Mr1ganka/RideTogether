import 'package:ride_together/features/auth/domain/entities/app_user.dart';

import '../entities/rider_profile.dart';


class RiderProfileMapper {

  static RiderProfile fromAppUser(
    AppUser user,
  ) {

    final now = DateTime.now();

    return RiderProfile(
      id: user.id,
      displayName: user.displayName ?? 'Rider',
      photoUrl: user.photoUrl,
      createdAt: now,
      updatedAt: now,
    );
  }
}