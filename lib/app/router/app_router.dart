import 'package:go_router/go_router.dart';
import 'package:ride_together/app/router/app_routes.dart';
import 'package:ride_together/features/auth/presentation/screens/login_screen.dart';
import 'package:ride_together/features/home/presentation/screens/home_screen.dart';
import 'package:ride_together/features/startup/presentation/screens/splash_screen.dart';

abstract final class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
        ),

        GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        ),
    ]
  );
}