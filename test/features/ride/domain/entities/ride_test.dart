import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

void main() {
  group('Ride Domain Entity', () {
    final now = DateTime(2026, 7, 28, 10, 0);
    final leaderProfile = RiderProfile(
      id: 'leader-1',
      displayName: 'Leader Alice',
      createdAt: now,
      updatedAt: now,
    );
    final leaderMember = RideMember(
      rider: leaderProfile,
      role: RiderRole.leader,
      joinedAt: now,
    );

    final ride = Ride(
      id: 'ride-100',
      name: 'Morning Cruise',
      description: 'Scenic highway route',
      joinCode: 'CRUISE',
      leader: leaderMember,
      status: RideStatus.recruiting,
      members: [leaderMember],
      createdAt: now,
    );

    test('getters return correct status and leader', () {
      expect(ride.isJoinable, isTrue);
      expect(ride.isActive, isFalse);
      expect(ride.getLeader, leaderMember);
    });

    test('isActive returns true when active or paused', () {
      final activeRide = ride.copyWith(status: RideStatus.active);
      final pausedRide = ride.copyWith(status: RideStatus.paused);

      expect(activeRide.isActive, isTrue);
      expect(pausedRide.isActive, isTrue);
    });

    test('copyWith updates fields correctly', () {
      final updated = ride.copyWith(
        name: 'Updated Name',
        status: RideStatus.completed,
      );

      expect(updated.name, 'Updated Name');
      expect(updated.status, RideStatus.completed);
      expect(updated.id, 'ride-100');
      expect(updated.joinCode, 'CRUISE');
    });
  });
}
