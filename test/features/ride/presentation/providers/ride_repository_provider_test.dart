import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('RideRepository & ActiveRide Providers', () {
    late FakeRideRepository fakeRideRepository;

    setUp(() {
      fakeRideRepository = FakeRideRepository();
    });

    tearDown(() {
      fakeRideRepository.dispose();
    });

    test('rideRepositoryProvider can be overridden', () {
      final container = ProviderContainer(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
        ],
      );
      addTearDown(container.dispose);

      final repo = container.read(rideRepositoryProvider);
      expect(repo, equals(fakeRideRepository));
    });

    test('activeRideProvider streams active ride from repository', () async {
      final container = ProviderContainer(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
        ],
      );
      addTearDown(container.dispose);

      final initialActiveRide = container.read(activeRideProvider);
      expect(initialActiveRide, const AsyncLoading<Ride?>());

      final createdRide = await fakeRideRepository.createRide(
        name: 'Weekend Ride',
      );

      final updatedActiveRide = await container.read(
        activeRideProvider.future,
      );
      expect(updatedActiveRide, equals(createdRide));
    });
  });
}
