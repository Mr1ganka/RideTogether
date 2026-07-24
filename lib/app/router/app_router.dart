import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ride_together/app/router/app_routes.dart';
import 'package:ride_together/app/router/router_refresh_notifier.dart';

import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ride_together/features/auth/presentation/screens/login_screen.dart';
import 'package:ride_together/features/home/presentation/screens/home_screen.dart';
import 'package:ride_together/features/location/presentation/screens/location_required_screen.dart';
import 'package:ride_together/features/startup/domain/entities/startup_result.dart';
import 'package:ride_together/features/startup/presentation/screens/splash_screen.dart';
import 'package:ride_together/features/startup/presentation/providers/startup_provider.dart';

abstract final class AppRouter {
  const AppRouter._();

  static GoRouter createRouter(WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    final startupState = ref.watch(startupProvider);

    final refreshNotifier = RouterRefreshNotifier();

    ref.listen(authStateProvider, (_, _) {
      refreshNotifier.refresh();
    });

    ref.listen(startupProvider, (_, _) {
      refreshNotifier.refresh();
    });

    return GoRouter(
      initialLocation: AppRoutes.splash,

      debugLogDiagnostics: true,

      refreshListenable: refreshNotifier,

      redirect: (context, state) {
        final location = state.matchedLocation;

        final isSplash = location == AppRoutes.splash;

        final isLogin = location == AppRoutes.login;

        final isLocationRequired = location == AppRoutes.locationRequired;

        final isAuthenticated = authState.valueOrNull != null;

        final startupResult = startupState.valueOrNull;

        // Wait for startup/auth only while we have no result yet
        if (startupState.isLoading && startupResult == null) {
          return AppRoutes.splash;
        }

        // Location permission has priority over authentication
        if (startupResult is StartupLocationRequired) {
          if (!isLocationRequired) {
            return AppRoutes.locationRequired;
          }

          return null;
        }

        // User is not logged in
        if (!isAuthenticated && !isLogin) {
          return AppRoutes.login;
        }

        // User is logged in
        // prevent going back to splash/login
        if (isAuthenticated && (isLogin || isSplash)) {
          return AppRoutes.home;
        }

        return null;
      },

      routes: [
        GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),

        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: AppRoutes.locationRequired,
          name: 'locationRequired',
          builder: (context, state) {
            final startupResult = ref.read(startupProvider).valueOrNull;

            if (startupResult is StartupLocationRequired) {
              return LocationRequiredScreen(status: startupResult.status);
            }

            // Safety fallback
            return const SplashScreen();
          },
        ),
      ],
    );
  }
}
