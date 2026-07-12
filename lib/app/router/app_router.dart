import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ride_together/app/router/app_routes.dart';
import 'package:ride_together/app/router/router_refresh_notifier.dart';

import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ride_together/features/auth/presentation/screens/login_screen.dart';
import 'package:ride_together/features/home/presentation/screens/home_screen.dart';
import 'package:ride_together/features/startup/presentation/screens/splash_screen.dart';
import 'package:ride_together/features/startup/presentation/providers/startup_provider.dart';


abstract final class AppRouter {
  const AppRouter._();


  static GoRouter createRouter(WidgetRef ref) {

    final authState = ref.watch(authStateProvider);

    final startupState = ref.watch(startupProvider);


    final refreshNotifier =
    RouterRefreshNotifier();


    ref.listen(
      authStateProvider,
      (_, _) {
        refreshNotifier.refresh();
      },
    );

    ref.listen(
      startupProvider,
      (_, _) {
        refreshNotifier.refresh();
      },
    );


    return GoRouter(

      initialLocation: AppRoutes.splash,

      debugLogDiagnostics: true,


      refreshListenable: refreshNotifier,


      redirect: (context, state) {


        final location =
            state.matchedLocation;


        final isSplash =
            location == AppRoutes.splash;


        final isLogin =
            location == AppRoutes.login;


        final isAuthenticated =
            authState.valueOrNull != null;



        // Firebase is still checking
        // keep user on splash
        if (startupState.isLoading || authState.isLoading) {
          return AppRoutes.splash;
          }



        // User is not logged in
        // send them to login
        if (!isAuthenticated && !isLogin) {
          return AppRoutes.login;
        }



        // User is logged in
        // don't allow login/splash
        if (isAuthenticated &&
            (isLogin || isSplash)) {

          return AppRoutes.home;
        }



        return null;
      },


      routes: [

        GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) =>
              const SplashScreen(),
        ),


        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) =>
              const LoginScreen(),
        ),


        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) =>
              const HomeScreen(),
        ),

      ],
    );
  }
}