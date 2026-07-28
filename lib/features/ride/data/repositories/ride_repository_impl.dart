import 'dart:math';

import 'package:ride_together/features/auth/domain/repositories/auth_repository.dart';
import 'package:ride_together/features/profile/domain/repositories/profile_repository.dart';
import 'package:ride_together/features/ride/data/datasources/ride_remote_data_source.dart';
import 'package:ride_together/features/ride/data/models/ride_member_model.dart';
import 'package:ride_together/features/ride/data/models/ride_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';
import 'package:ride_together/features/ride/domain/repositories/ride_repository.dart';

/// Implementation of [RideRepository] managing Ride lifecycle operations.
/// 
/// JAVA ANALOGY:
/// `public class RideRepositoryImpl implements RideRepository`
class RideRepositoryImpl implements RideRepository {
  final RideRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;
  final ProfileRepository profileRepository;

  RideRepositoryImpl({
    required this.remoteDataSource,
    required this.authRepository,
    required this.profileRepository,
  });

  @override
  Future<Ride> createRide({
    required String name,
    String? description,
    String? customJoinCode,
  }) async {
    final user = authRepository.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated to create a ride.');
    }

    final profile = await profileRepository.getProfile(user.id);
    if (profile == null) {
      throw Exception('User profile not found.');
    }

    final joinCode = (customJoinCode != null && customJoinCode.trim().isNotEmpty)
        ? customJoinCode.trim().toUpperCase()
        : _generateJoinCode();

    final now = DateTime.now();
    final leaderMember = RideMemberModel(
      rider: profile,
      role: RiderRole.leader,
      joinedAt: now,
    );

    final rideId = 'ride_${now.millisecondsSinceEpoch}_${_randomAlphaNumeric(4)}';

    final rideModel = RideModel(
      id: rideId,
      name: name,
      description: description,
      joinCode: joinCode,
      leader: leaderMember,
      status: RideStatus.recruiting,
      members: [leaderMember],
      createdAt: now,
    );

    return await remoteDataSource.createRide(rideModel);
  }

  @override
  Future<Ride> joinRideByCode(String joinCode) async {
    final user = authRepository.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated to join a ride.');
    }

    final profile = await profileRepository.getProfile(user.id);
    if (profile == null) {
      throw Exception('User profile not found.');
    }

    final rideModel = await remoteDataSource.getRideByJoinCode(joinCode);
    if (rideModel == null) {
      throw Exception('No ride found matching join code: $joinCode');
    }

    if (!rideModel.isJoinable) {
      throw Exception('This ride is no longer joinable.');
    }

    // Check if user is already a member
    final isAlreadyMember = rideModel.members.any((m) => m.rider.id == profile.id);
    if (isAlreadyMember) {
      return rideModel; // User already in ride
    }

    final newMember = RideMemberModel(
      rider: profile,
      role: RiderRole.rider,
      joinedAt: DateTime.now(),
    );

    final updatedMembers = [...rideModel.members, newMember];
    final updatedRide = RideModel.fromEntity(
      rideModel.copyWith(members: updatedMembers),
    );

    await remoteDataSource.updateRideMembers(rideModel.id, updatedRide);
    return updatedRide;
  }

  @override
  Future<Ride?> getRide(String rideId) {
    return remoteDataSource.getRide(rideId);
  }

  @override
  Stream<Ride?> watchRide(String rideId) {
    return remoteDataSource.watchRide(rideId);
  }

  @override
  Stream<Ride?> watchActiveRide() {
    final user = authRepository.currentUser;
    if (user == null) {
      return Stream.value(null);
    }
    return remoteDataSource.watchActiveRideForUser(user.id);
  }

  @override
  Future<void> updateRideStatus({
    required String rideId,
    required RideStatus status,
  }) async {
    await remoteDataSource.updateRideStatus(rideId, status);
  }

  @override
  Future<void> leaveRide(String rideId) async {
    final user = authRepository.currentUser;
    if (user == null) return;

    final rideModel = await remoteDataSource.getRide(rideId);
    if (rideModel == null) return;

    final updatedMembers = rideModel.members
        .where((m) => m.rider.id != user.id)
        .toList();

    final updatedRide = RideModel.fromEntity(
      rideModel.copyWith(members: updatedMembers),
    );

    await remoteDataSource.updateRideMembers(rideId, updatedRide);
  }

  /// Generates a random 6-character alphanumeric uppercase join code (e.g. "RIDE68").
  String _generateJoinCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
  }

  /// Generates a random alphanumeric suffix string of length [length].
  String _randomAlphaNumeric(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
