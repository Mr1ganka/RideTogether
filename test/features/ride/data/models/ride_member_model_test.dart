import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/ride/data/models/ride_member_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

void main() {
  group('RideMemberModel', () {
    final now = DateTime.utc(2026, 7, 28, 12, 0, 0);
    final profile = RiderProfile(
      id: 'u-1',
      displayName: 'Bob',
      createdAt: now,
      updatedAt: now,
    );

    final model = RideMemberModel(
      rider: profile,
      role: RiderRole.rider,
      joinedAt: now,
    );

    test('toMap and fromMap serialize and deserialize correctly', () {
      final map = model.toMap();

      expect(map['role'], 'rider');
      expect(map['joinedAt'], now.toIso8601String());
      expect(map['completedAt'], isNull);

      final deserialized = RideMemberModel.fromMap(map);
      expect(deserialized.rider.id, profile.id);
      expect(deserialized.rider.displayName, profile.displayName);
      expect(deserialized.role, RiderRole.rider);
      expect(deserialized.joinedAt, now);
    });

    test('fromEntity converts entity to model', () {
      final entity = RideMember(
        rider: profile,
        role: RiderRole.coleader,
        joinedAt: now,
      );

      final modelFromEntity = RideMemberModel.fromEntity(entity);
      expect(modelFromEntity.role, RiderRole.coleader);
      expect(modelFromEntity.rider.id, profile.id);
    });
  });
}
