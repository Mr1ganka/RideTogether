import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ride_together/features/profile/data/model/rider_profile_model.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';

class MockTimestamp extends Mock {
  DateTime toDate();
}

void main() {
  group('RiderProfileModel', () {
    test('converts entity to model and map', () {
      final now = DateTime.now();
      final profile = RiderProfile(
        id: 'r1',
        displayName: 'Sam',
        photoUrl: 'pic.png',
        createdAt: now,
        updatedAt: now,
      );

      final model = RiderProfileModel.fromEntity(profile);
      expect(model.id, 'r1');

      final map = model.toMap();
      expect(map['id'], 'r1');
      expect(map['displayName'], 'Sam');
      expect(map['photoUrl'], 'pic.png');
      expect(map['createdAt'], now);
      expect(map['updatedAt'], now);
    });

    test('creates model from map with toDate method', () {
      final now = DateTime.now();
      final mockTs = MockTimestamp();
      when(() => mockTs.toDate()).thenReturn(now);

      final map = {
        'id': 'r2',
        'displayName': 'Alex',
        'photoUrl': null,
        'createdAt': mockTs,
        'updatedAt': mockTs,
      };

      final model = RiderProfileModel.fromMap(map);
      expect(model.id, 'r2');
      expect(model.displayName, 'Alex');
      expect(model.createdAt, now);
    });
  });
}
