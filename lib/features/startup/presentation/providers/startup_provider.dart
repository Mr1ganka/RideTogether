import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/startup/domain/entities/startup_result.dart';

import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../profile/presentation/providers/current_profile_provider.dart';
import '../../../location/domain/entities/permission_status_entity.dart';
import '../../../location/presentation/providers/location_permission_provider.dart';

final startupProvider = FutureProvider<StartupResult>((ref) async {
  // Keep splash visible for minimum duration
  await Future.delayed(const Duration(seconds: 2));

  final permissionStatus = await ref
      .read(locationPermissionProvider.notifier)
      .ensurePermissionGranted();

  if (permissionStatus != PermissionStatusEntity.granted) {
    return StartupLocationRequired(permissionStatus);
  }

  final user = await ref.watch(authStateProvider.future);

  if (user != null) {
    await ref.watch(currentProfileProvider.future);
  }

  return const StartupReady();
});
