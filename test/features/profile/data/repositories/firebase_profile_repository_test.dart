import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ride_together/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:ride_together/features/profile/data/model/rider_profile_model.dart';
import 'package:ride_together/features/profile/data/repositories/firebase_profile_repository.dart';
import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      RiderProfileModel(
        id: 'fallback',
        displayName: 'fallback',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  group('FirebaseProfileRepository', () {
    test('delegates getProfile to remoteDataSource', () async {
      final dataSource = MockProfileRemoteDataSource();
      final repository = FirebaseProfileRepository(
        remoteDataSource: dataSource,
      );

      final now = DateTime.now();
      final model = RiderProfileModel(
        id: 'u1',
        displayName: 'Rider 1',
        createdAt: now,
        updatedAt: now,
      );

      when(() => dataSource.getProfile('u1')).thenAnswer((_) async => model);

      final profile = await repository.getProfile('u1');
      expect(profile?.id, 'u1');
      verify(() => dataSource.getProfile('u1')).called(1);
    });

    test(
      'delegates createProfile and updateProfile to remoteDataSource',
      () async {
        final dataSource = MockProfileRemoteDataSource();
        final repository = FirebaseProfileRepository(
          remoteDataSource: dataSource,
        );

        final now = DateTime.now();
        final profile = RiderProfile(
          id: 'u2',
          displayName: 'Rider 2',
          createdAt: now,
          updatedAt: now,
        );

        when(() => dataSource.createProfile(any())).thenAnswer((_) async {});
        when(() => dataSource.updateProfile(any())).thenAnswer((_) async {});

        await repository.createProfile(profile);
        verify(() => dataSource.createProfile(any())).called(1);

        await repository.updateProfile(profile);
        verify(() => dataSource.updateProfile(any())).called(1);
      },
    );
  });
}
