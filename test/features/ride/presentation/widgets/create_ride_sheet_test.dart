import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';
import 'package:ride_together/features/ride/presentation/widgets/create_ride_sheet.dart';

import '../../../../helpers/fake_ride_repository.dart';

void main() {
  group('CreateRideSheet Widget Tests', () {
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
            body: CreateRideSheet(),
          ),
        ),
      );
    }

    testWidgets('renders CreateRideSheet UI fields correctly', (tester) async {
      await tester.pumpWidget(createTestableWidget());

      expect(find.text('Create Group Ride'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Ride Name *'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, 'Create & Start Ride'),
        findsOneWidget,
      );
    });

    testWidgets('shows validation error when submitting empty ride name', (tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.tap(find.widgetWithText(FilledButton, 'Create & Start Ride'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a ride name'), findsOneWidget);
    });
  });
}
