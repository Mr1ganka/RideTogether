import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';
import 'package:ride_together/features/ride/presentation/widgets/active_ride_panel.dart';

import '../../../../helpers/fake_auth_repository.dart';
import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('ActiveRidePanel Widget Tests', () {
    late FakeRideRepository fakeRideRepository;
    late FakeAuthRepository fakeAuthRepository;

    setUp(() {
      fakeRideRepository = FakeRideRepository();
      fakeAuthRepository = FakeAuthRepository(
        initialUser: const AppUser(id: 'leader-1', email: 'leader@example.com'),
      );
    });

    tearDown(() {
      fakeRideRepository.dispose();
    });

    Widget createTestableWidget() {
      return ProviderScope(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
          authRepositoryProvider.overrideWithValue(fakeAuthRepository),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: ActiveRidePanel(),
          ),
        ),
      );
    }

    testWidgets('renders empty widget when no active ride exists', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ActiveRidePanel), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('renders active ride details when ride exists', (tester) async {
      await fakeRideRepository.createRide(name: 'Coastal Rally');

      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Coastal Rally'), findsOneWidget);
      expect(find.text('PLANNED'), findsOneWidget);
      expect(find.text('JOIN12'), findsOneWidget);
    });
  });
}
