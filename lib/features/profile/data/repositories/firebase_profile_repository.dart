import '../../domain/entities/rider_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';
import '../model/rider_profile_model.dart';

class FirebaseProfileRepository implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  FirebaseProfileRepository({
    required this.remoteDataSource,
  });


  @override
  Future<RiderProfile?> getProfile(
    String userId,
  ) async {
    return await remoteDataSource.getProfile(userId);
  }


  @override
  Future<void> createProfile(
    RiderProfile profile,
  ) async {
    final model = RiderProfileModel.fromEntity(
      profile,
    );

    await remoteDataSource.createProfile(
      model,
    );
  }


  @override
  Future<void> updateProfile(
    RiderProfile profile,
  ) async {
    final model = RiderProfileModel.fromEntity(
      profile,
    );

    await remoteDataSource.updateProfile(
      model,
    );
  }
}