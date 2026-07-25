import '../entities/rider_profile.dart';

abstract class ProfileRepository {
  Future<RiderProfile?> getProfile(String userId);

  Future<void> createProfile(RiderProfile profile);

  Future<void> updateProfile(RiderProfile profile);
}
