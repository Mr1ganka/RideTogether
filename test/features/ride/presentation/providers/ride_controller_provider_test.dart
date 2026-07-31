import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/map_mode.dart';
import 'package:ride_together/features/map/presentation/providers/map_mode_provider.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_controller_provider.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('RideController Provider', () {
    late FakeRideRepository fakeRideRepository;
    late ProviderContainer container;

    setUp(() {
      fakeRideRepository = FakeRideRepository();
      container = ProviderContainer(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
      fakeRideRepository.dispose();
    });

    test('initial state of rideControllerProvider is null', () {
      final state = container.read(rideControllerProvider);
      expect(state.value, isNull);
      expect(container.read(mapModeProvider), MapMode.idle);
    });

    test(
      'createRide creates ride and switches mapMode to activeRide',
      () async {
        final controller = container.read(rideControllerProvider.notifier);

        final ride = await controller.createRide(
          name: 'Mountain Pass Cruise',
          description: 'A morning ride through the hills',
          customJoinCode: 'HILL99',
        );

        expect(ride, isNotNull);
        expect(ride?.name, 'Mountain Pass Cruise');
        expect(ride?.joinCode, 'HILL99');
        expect(container.read(mapModeProvider), MapMode.activeRide);
        expect(
          container.read(rideControllerProvider),
          AsyncData(ride),
        );
      },
    );

    test('joinRide joins ride by code and switches mapMode to activeRide', () async {
      final controller = container.read(rideControllerProvider.notifier);

      final ride = await controller.joinRide('HILL99');

      expect(ride, isNotNull);
      expect(ride?.joinCode, 'HILL99');
      expect(ride?.members.length, 2);
      expect(container.read(mapModeProvider), MapMode.activeRide);
      expect(
        container.read(rideControllerProvider),
        AsyncData(ride),
      );
    });

    test(
      'updateRideStatus updates status and switches mapMode to idle on completed',
      () async {
        final controller = container.read(rideControllerProvider.notifier);
        final ride = await controller.createRide(name: 'Test Ride');
        expect(container.read(mapModeProvider), MapMode.activeRide);

        await controller.updateRideStatus(
          rideId: ride!.id,
          status: RideStatus.active,
        );
        expect(container.read(mapModeProvider), MapMode.activeRide);

        await controller.updateRideStatus(
          rideId: ride.id,
          status: RideStatus.completed,
        );
        expect(container.read(mapModeProvider), MapMode.idle);
      },
    );

    test('leaveRide leaves active ride and switches mapMode to idle', () async {
      final controller = container.read(rideControllerProvider.notifier);
      final ride = await controller.createRide(name: 'Test Ride');
      expect(container.read(mapModeProvider), MapMode.activeRide);

      await controller.leaveRide(ride!.id);
      expect(container.read(mapModeProvider), MapMode.idle);
    });

    test('createRide failure sets AsyncError state', () async {
      fakeRideRepository.shouldThrowError = true;
      final controller = container.read(rideControllerProvider.notifier);

      final ride = await controller.createRide(name: 'Failed Ride');

      expect(ride, isNull);
      expect(container.read(rideControllerProvider).hasError, isTrue);
    });
  });
}
