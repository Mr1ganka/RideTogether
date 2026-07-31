import 'dart:async';

import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';
import 'package:ride_together/features/ride/domain/repositories/ride_repository.dart';

class FakeRideRepository implements RideRepository {
  FakeRideRepository({this.activeRide});

  Ride? activeRide;
  bool shouldThrowError = false;
  final Map<String, RiderLocation> riderLocations = {};
  final StreamController<Ride?> _activeRideStreamController =
      StreamController<Ride?>.broadcast();
  final StreamController<List<RiderLocation>> _locationsStreamController =
      StreamController<List<RiderLocation>>.broadcast();

  @override
  Future<Ride> createRide({
    required String name,
    String? description,
    String? customJoinCode,
  }) async {
    if (shouldThrowError) {
      throw Exception('Failed to create ride');
    }

    final now = DateTime.parse('2026-07-30T10:00:00Z');

    final leaderMember = RideMember(
      rider: RiderProfile(
        id: 'leader-1',
        displayName: 'Leader Rider',
        createdAt: now,
        updatedAt: now,
      ),
      role: RiderRole.leader,
      joinedAt: now,
    );

    final newRide = Ride(
      id: 'ride-123',
      name: name,
      description: description,
      joinCode: customJoinCode ?? 'JOIN12',
      leader: leaderMember,
      status: RideStatus.planned,
      members: [leaderMember],
      createdAt: now,
    );

    activeRide = newRide;
    _activeRideStreamController.add(activeRide);
    return newRide;
  }

  @override
  Future<Ride> joinRideByCode(String joinCode) async {
    if (shouldThrowError) {
      throw Exception('Failed to join ride');
    }

    final now = DateTime.parse('2026-07-30T10:00:00Z');

    final leaderMember = RideMember(
      rider: RiderProfile(
        id: 'leader-1',
        displayName: 'Leader',
        createdAt: now,
        updatedAt: now,
      ),
      role: RiderRole.leader,
      joinedAt: now,
    );

    final joinedMember = RideMember(
      rider: RiderProfile(
        id: 'user-2',
        displayName: 'Joined Rider',
        createdAt: now,
        updatedAt: now,
      ),
      role: RiderRole.rider,
      joinedAt: now,
    );

    final joinedRide = Ride(
      id: 'ride-456',
      name: 'Group Ride',
      joinCode: joinCode.toUpperCase(),
      leader: leaderMember,
      status: RideStatus.recruiting,
      members: [leaderMember, joinedMember],
      createdAt: now,
    );

    activeRide = joinedRide;
    _activeRideStreamController.add(activeRide);
    return joinedRide;
  }

  @override
  Future<Ride?> getRide(String rideId) async {
    if (shouldThrowError) {
      throw Exception('Failed to get ride');
    }
    return activeRide?.id == rideId ? activeRide : null;
  }

  @override
  Stream<Ride?> watchRide(String rideId) {
    return Stream.value(activeRide?.id == rideId ? activeRide : null);
  }

  @override
  Stream<Ride?> watchActiveRide() async* {
    yield activeRide;
    yield* _activeRideStreamController.stream;
  }

  @override
  Future<void> updateRideStatus({
    required String rideId,
    required RideStatus status,
  }) async {
    if (shouldThrowError) {
      throw Exception('Failed to update status');
    }
    if (activeRide != null && activeRide!.id == rideId) {
      activeRide = activeRide!.copyWith(status: status);
      _activeRideStreamController.add(activeRide);
    }
  }

  @override
  Future<void> leaveRide(String rideId) async {
    if (shouldThrowError) {
      throw Exception('Failed to leave ride');
    }
    if (activeRide != null && activeRide!.id == rideId) {
      activeRide = null;
      _activeRideStreamController.add(null);
    }
  }

  @override
  Future<void> updateRiderLocation({
    required String rideId,
    required RiderLocation location,
  }) async {
    if (shouldThrowError) {
      throw Exception('Failed to update location');
    }
    riderLocations[location.userId] = location;
    _locationsStreamController.add(riderLocations.values.toList());
  }

  @override
  Stream<List<RiderLocation>> watchRideLocations(String rideId) async* {
    yield riderLocations.values.toList();
    yield* _locationsStreamController.stream;
  }

  void dispose() {
    _activeRideStreamController.close();
    _locationsStreamController.close();
  }
}
