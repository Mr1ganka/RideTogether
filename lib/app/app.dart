import 'package:flutter/material.dart';
import 'package:ride_together/app/router/app_router.dart';
import 'package:ride_together/core/theme/app_theme.dart';

class RideTogetherApp extends StatelessWidget {
  const RideTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // title: 'RideTogether',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
