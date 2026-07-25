import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/app/app.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/home/presentation/screens/home_screen.dart';
import 'package:ride_together/features/startup/domain/entities/startup_result.dart';
import 'package:ride_together/features/startup/presentation/providers/startup_provider.dart';

import 'helpers/fake_auth_repository.dart';

void main() {
  testWidgets('shows login after the splash screen for a signed-out rider', (
    WidgetTester tester,
  ) async {
    final repository = FakeAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          startupProvider.overrideWith((ref) async => const StartupReady()),
        ],
        child: const RideTogetherApp(),
      ),
    );

    expect(find.text('RideTogether'), findsOneWidget);
    expect(find.text('Continue with Google'), findsNothing);

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('redirects an authenticated rider from splash to home', (
    WidgetTester tester,
  ) async {
    final repository = FakeAuthRepository(
      initialUser: const AppUser(id: 'rider-1'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          startupProvider.overrideWith((ref) async => const StartupReady()),
        ],
        child: const RideTogetherApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Continue with Google'), findsNothing);
  });
}
