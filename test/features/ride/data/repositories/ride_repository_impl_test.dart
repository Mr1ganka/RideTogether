import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/domain/repositories/auth_repository.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/profile/domain/repositories/profile_repository.dart';
import 'package:ride_together/features/ride/data/datasources/ride_remote_data_source.dart';
import 'package:ride_together/features/ride/data/models/ride_member_model.dart';
import 'package:ride_together/features/ride/data/models/ride_model.dart';
import 'package:ride_together/features/ride/data/repositories/ride_repository_impl.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

class FakeRideRemoteDataSource implements RideRemoteDataSource {
  final Map<String, RideModel> rides = {};

  @override
  Future<RideModel> createRide(RideModel ride) async {
    rides[ride.id] = ride;
    return ride;
  }

  @override
  Future<RideModel?> getRide(String rideId) async {
    return rides[rideId];
  }

  @override
  Future<RideModel?> getRideByJoinCode(String joinCode) async {
    try {
      return rides.values.firstWhere(
        (r) => r.joinCode.toUpperCase() == joinCode.toUpperCase(),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<RideModel?> watchRide(String rideId) {
    return Stream.value(rides[rideId]);
  }

  @override
  Stream<RideModel?> watchActiveRideForUser(String userId) {
    try {
      final ride = rides.values.firstWhere(
        (r) =>
            r.members.any((m) => m.rider.id == userId) && r.isJoinable,
      );
      return Stream.value(ride);
    } catch (_) {
      return Stream.value(null);
    }
  }

  @override
  Future<void> updateRide(RideModel ride) async {
    rides[ride.id] = ride;
  }

  @override
  Future<void> updateRideMembers(String rideId, RideModel updatedRide) async {
    rides[rideId] = updatedRide;
  }

  @override
  Future<void> updateRideStatus(String rideId, RideStatus status) async {
    if (rides.containsKey(rideId)) {
      rides[rideId] = RideModel.fromEntity(
        rides[rideId]!.copyWith(status: status),
      );
    }
  }
}

class FakeAuthRepo implements AuthRepository {
  AppUser? _currentUser;
  FakeAuthRepo(this._currentUser);

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> authStateChanges() => Stream.value(_currentUser);

  @override
  Future<AppUser?> signInWithGoogle() async => _currentUser;

  @override
  Future<void> signOut() async => _currentUser = null;
}

class FakeProfileRepo implements ProfileRepository {
  final Map<String, RiderProfile> profiles = {};

  @override
  Future<RiderProfile?> getProfile(String userId) async {
    return profiles[userId];
  }

  @override
  Future<void> createProfile(RiderProfile profile) async {
    profiles[profile.id] = profile;
  }

  @override
  Future<void> updateProfile(RiderProfile profile) async {
    profiles[profile.id] = profile;
  }
}

void main() {
  group('RideRepositoryImpl', () {
    late FakeRideRemoteDataSource remoteDataSource;
    late FakeAuthRepo authRepo;
    late FakeProfileRepo profileRepo;
    late RideRepositoryImpl repository;

    final now = DateTime.utc(2026, 7, 28, 10, 0, 0);
    const user = AppUser(id: 'user-1', email: 'test@example.com');
    final profile = RiderProfile(
      id: 'user-1',
      displayName: 'Rider One',
      createdAt: now,
      updatedAt: now,
    );

    setUp(() {
      remoteDataSource = FakeRideRemoteDataSource();
      authRepo = FakeAuthRepo(user);
      profileRepo = FakeProfileRepo();
      profileRepo.profiles[user.id] = profile;

      repository = RideRepositoryImpl(
        remoteDataSource: remoteDataSource,
        authRepository: authRepo,
        profileRepository: profileRepo,
      );
    });

    test('createRide creates and returns a new ride with leader', () async {
      final ride = await repository.createRide(
        name: 'Sunday Run',
        description: 'Casual Sunday ride',
        customJoinCode: 'SUNDAY',
      );

      expect(ride.name, 'Sunday Run');
      expect(ride.joinCode, 'SUNDAY');
      expect(ride.status, RideStatus.recruiting);
      expect(ride.members.length, 1);
      expect(ride.leader.rider.id, user.id);
    });

    test('createRide throws error if unauthenticated', () async {
      final unauthRepo = FakeAuthRepo(null);
      final unauthRepository = RideRepositoryImpl(
        remoteDataSource: remoteDataSource,
        authRepository: unauthRepo,
        profileRepository: profileRepo,
      );

      expect(
        () => unauthRepository.createRide(name: 'Fail Ride'),
        throwsA(isA<Exception>()),
      );
    });

    test('joinRideByCode adds user as member when ride exists and is joinable', () async {
      final leaderProfile = RiderProfile(
        id: 'leader-1',
        displayName: 'Leader',
        createdAt: now,
        updatedAt: now,
      );
      final leaderMember = RideMemberModel(
        rider: leaderProfile,
        role: RiderRole.leader,
        joinedAt: now,
      );

      final initialRide = RideModel(
        id: 'ride-abc',
        name: 'Group Ride',
        joinCode: 'JOINME',
        leader: leaderMember,
        status: RideStatus.recruiting,
        members: [leaderMember],
        createdAt: now,
      );

      await remoteDataSource.createRide(initialRide);

      final joinedRide = await repository.joinRideByCode('JOINME');

      expect(joinedRide.members.length, 2);
      expect(joinedRide.members.any((m) => m.rider.id == user.id), isTrue);
    });

    test('leaveRide removes current user from ride members', () async {
      final ride = await repository.createRide(name: 'Leave Test');
      expect(remoteDataSource.rides[ride.id]!.members.length, 1);

      await repository.leaveRide(ride.id);

      expect(remoteDataSource.rides[ride.id]!.members.length, 0);
    });

    test('updateRideStatus updates the status', () async {
      final ride = await repository.createRide(name: 'Status Test');

      await repository.updateRideStatus(
        rideId: ride.id,
        status: RideStatus.active,
      );

      final updated = await repository.getRide(ride.id);
      expect(updated?.status, RideStatus.active);
    });
  });
}
