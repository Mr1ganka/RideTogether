import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_location_providers.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

import '../../../../helpers/fake_auth_repository.dart';
import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('Ride Location Providers Tests', () {
    late FakeRideRepository fakeRideRepository;
    late FakeAuthRepository fakeAuthRepository;
    late ProviderContainer container;

    setUp(() {
      fakeRideRepository = FakeRideRepository();
      fakeAuthRepository = FakeAuthRepository(
        initialUser: const AppUser(id: 'user-1', email: 'rider1@example.com'),
      );
      container = ProviderContainer(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
          authRepositoryProvider.overrideWithValue(fakeAuthRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
      fakeRideRepository.dispose();
    });

    test('groupRiderLocationsProvider returns empty list when no active ride', () async {
      await container.read(activeRideProvider.future);
      final locations = await container.read(groupRiderLocationsProvider.future);
      expect(locations, isEmpty);
    });

    test('groupRiderLocationsProvider streams group member locations', () async {
      final ride = await fakeRideRepository.createRide(name: 'Group Ride');
      await fakeRideRepository.updateRiderLocation(
        rideId: ride.id,
        location: RiderLocation(
          userId: 'user-2',
          latitude: 12.9716,
          longitude: 77.5946,
          updatedAt: DateTime.now(),
        ),
      );

      await container.read(activeRideProvider.future);
      final locations = await container.read(groupRiderLocationsProvider.future);
      expect(locations.length, 1);
      expect(locations.first.userId, 'user-2');
    });

    test('groupRiderMarkersProvider creates MapMarker for non-local group members', () async {
      await fakeRideRepository.joinRideByCode('JOIN12');

      await fakeRideRepository.updateRiderLocation(
        rideId: 'ride-456',
        location: RiderLocation(
          userId: 'leader-1',
          latitude: 12.9716,
          longitude: 77.5946,
          updatedAt: DateTime.now(),
        ),
      );

      await container.read(activeRideProvider.future);
      await container.read(groupRiderLocationsProvider.future);

      final markers = container.read(groupRiderMarkersProvider);
      expect(markers.length, 1);
      expect(markers.first.id, 'rider_marker_leader-1');
    });
  });
}
