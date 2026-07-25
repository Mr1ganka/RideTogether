import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ride_together/app/router/app_router.dart';
import 'package:ride_together/core/providers/app_lifecycle_providers.dart';
import 'package:ride_together/core/theme/app_theme.dart';


class RideTogetherApp extends ConsumerWidget {
  const RideTogetherApp({super.key});


  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.watch(appLifecycleProvider);

    return MaterialApp.router(

      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.system,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      routerConfig:
          AppRouter.createRouter(ref),

    );
  }
}