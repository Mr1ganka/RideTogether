import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';
import 'package:ride_together/features/ride/presentation/widgets/join_ride_sheet.dart';

import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('JoinRideSheet Widget Tests', () {
    late FakeRideRepository fakeRideRepository;

    setUp(() {
      fakeRideRepository = FakeRideRepository();
    });

    tearDown(() {
      fakeRideRepository.dispose();
    });

    Widget createTestableWidget() {
      return ProviderScope(
        overrides: [
          rideRepositoryProvider.overrideWithValue(fakeRideRepository),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: JoinRideSheet(),
          ),
        ),
      );
    }

    testWidgets('renders JoinRideSheet UI elements correctly', (tester) async {
      await tester.pumpWidget(createTestableWidget());

      expect(find.text('Join Group Ride'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Join Ride'), findsOneWidget);
      expect(
        find.text('Want to create a new ride instead?'),
        findsOneWidget,
      );
    });

    testWidgets('shows validation error when submitting empty code', (tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.tap(find.widgetWithText(FilledButton, 'Join Ride'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid 6-character code'), findsOneWidget);
    });
  });
}
