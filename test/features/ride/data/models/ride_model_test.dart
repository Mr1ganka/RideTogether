import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/ride/data/models/ride_member_model.dart';
import 'package:ride_together/features/ride/data/models/ride_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

void main() {
  group('RideModel', () {
    final now = DateTime.utc(2026, 7, 28, 10, 0, 0);
    final leaderProfile = RiderProfile(
      id: 'leader-1',
      displayName: 'Leader Alice',
      createdAt: now,
      updatedAt: now,
    );
    final leaderMember = RideMemberModel(
      rider: leaderProfile,
      role: RiderRole.leader,
      joinedAt: now,
    );

    final rideModel = RideModel(
      id: 'ride-123',
      name: 'Weekend Ride',
      description: 'Fun weekend trip',
      joinCode: 'WKD123',
      leader: leaderMember,
      status: RideStatus.recruiting,
      members: [leaderMember],
      createdAt: now,
    );

    test('toMap and fromMap serialize and deserialize correctly', () {
      final map = rideModel.toMap();

      expect(map['id'], 'ride-123');
      expect(map['name'], 'Weekend Ride');
      expect(map['joinCode'], 'WKD123');
      expect(map['status'], 'recruiting');
      expect(map['createdAt'], now.toIso8601String());

      final deserialized = RideModel.fromMap(map);

      expect(deserialized.id, 'ride-123');
      expect(deserialized.name, 'Weekend Ride');
      expect(deserialized.joinCode, 'WKD123');
      expect(deserialized.status, RideStatus.recruiting);
      expect(deserialized.members.length, 1);
      expect(deserialized.members.first.rider.id, 'leader-1');
    });

    test('fromMap uses documentId when provided', () {
      final map = rideModel.toMap();
      map.remove('id');

      final deserialized = RideModel.fromMap(map, documentId: 'override-id');
      expect(deserialized.id, 'override-id');
    });

    test('fromEntity creates RideModel from Ride entity', () {
      final entity = Ride(
        id: 'ride-999',
        name: 'Entity Ride',
        joinCode: 'ENT999',
        leader: leaderMember,
        status: RideStatus.planned,
        members: [leaderMember],
        createdAt: now,
      );

      final model = RideModel.fromEntity(entity);
      expect(model.id, 'ride-999');
      expect(model.name, 'Entity Ride');
      expect(model.status, RideStatus.planned);
    });
  });
}
