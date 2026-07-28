import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/app/router/app_router.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';
import 'package:ride_together/features/startup/domain/entities/startup_result.dart';
import 'package:ride_together/features/startup/presentation/providers/startup_provider.dart';

import '../../helpers/fake_auth_repository.dart';

void main() {
  group('AppRouter', () {
    testWidgets(
      'redirects to locationRequired when startup returns locationRequired',
      (tester) async {
        final repository = FakeAuthRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWithValue(repository),
              startupProvider.overrideWith(
                (ref) async => const StartupLocationRequired(
                  PermissionStatusEntity.denied,
                ),
              ),
            ],
            child: Consumer(
              builder: (context, ref, _) {
                final router = AppRouter.createRouter(ref);
                return MaterialApp.router(routerConfig: router);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Location access needed'), findsOneWidget);
      },
    );

    testWidgets('redirects to login when unauthenticated and startup ready', (
      tester,
    ) async {
      final repository = FakeAuthRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(repository),
            startupProvider.overrideWith((ref) async => const StartupReady()),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              final router = AppRouter.createRouter(ref);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('redirects to home when authenticated and startup ready', (
      tester,
    ) async {
      final repository = FakeAuthRepository(
        initialUser: const AppUser(id: 'user-10'),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(repository),
            startupProvider.overrideWith((ref) async => const StartupReady()),
          ],
          child: Consumer(
            builder: (context, ref, _) {
              final router = AppRouter.createRouter(ref);
              return MaterialApp.router(routerConfig: router);
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Ride'), findsOneWidget);
    });
  });
}
