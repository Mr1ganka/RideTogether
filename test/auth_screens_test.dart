import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/auth/presentation/screens/login_screen.dart';
import 'package:ride_together/features/home/presentation/screens/home_screen.dart';
import 'package:ride_together/features/location/presentation/providers/initial_position_provider.dart';

import 'helpers/fake_auth_repository.dart';

void main() {
  testWidgets('login screen requests Google sign-in', (
    WidgetTester tester,
  ) async {
    final repository = FakeAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(
      find.text('Ride together.\nStay connected.\nRide safer.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Continue with Google'));
    await tester.pump();

    expect(repository.signInCallCount, 1);
  });

  testWidgets('home screen requests sign-out', (WidgetTester tester) async {
    final repository = FakeAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          initialPositionProvider.overrideWith((ref) async => null),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.byType(HomeScreen), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pump();

    expect(repository.signOutCallCount, 1);
  });
}
