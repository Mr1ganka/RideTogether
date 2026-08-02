import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/location/presentation/providers/background_consent_provider.dart';
import 'package:ride_together/features/location/presentation/widgets/background_consent_sheet.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';
import 'package:ride_together/features/ride/presentation/widgets/active_ride_panel.dart';

import '../../../../helpers/fake_auth_repository.dart';
import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('Background Location Consent Tests', () {
    late FakeRideRepository fakeRideRepository;
    late FakeAuthRepository fakeAuthRepository;

    setUp(() {
      BackgroundConsentSheet.resetStateForTesting();
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

    testWidgets('ActiveRidePanel renders location toggle button and opens consent sheet on tap', (tester) async {
      await fakeRideRepository.createRide(name: 'Group Ride');

      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Group Ride'), findsOneWidget);
      expect(find.byIcon(Icons.location_off_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.location_off_outlined));
      await tester.pumpAndSettle();

      expect(find.byType(BackgroundConsentSheet), findsOneWidget);
      expect(find.text('Background Location'), findsOneWidget);
      expect(find.text('Only While Open'), findsOneWidget);
      expect(find.text('Share in Background'), findsOneWidget);

      await tester.tap(find.text('Only While Open'));
      await tester.pump();
      await tester.pumpAndSettle();
    });

    testWidgets('Tapping "Only While Open" declines background consent', (tester) async {
      await fakeRideRepository.createRide(name: 'Group Ride');

      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            rideRepositoryProvider.overrideWithValue(fakeRideRepository),
            authRepositoryProvider.overrideWithValue(fakeAuthRepository),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  capturedRef = ref;
                  return const ActiveRidePanel();
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.location_off_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Only While Open'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(BackgroundConsentSheet), findsNothing);
      expect(capturedRef.read(backgroundConsentProvider), BackgroundConsentState.declined);
    });

    testWidgets('Tapping "Share in Background" accepts background consent', (tester) async {
      await fakeRideRepository.createRide(name: 'Group Ride');

      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            rideRepositoryProvider.overrideWithValue(fakeRideRepository),
            authRepositoryProvider.overrideWithValue(fakeAuthRepository),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  capturedRef = ref;
                  return const ActiveRidePanel();
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.location_off_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Share in Background'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(BackgroundConsentSheet), findsNothing);
      expect(capturedRef.read(backgroundConsentProvider), BackgroundConsentState.accepted);
    });
  });
}
