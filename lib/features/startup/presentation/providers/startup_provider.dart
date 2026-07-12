import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../profile/presentation/providers/current_profile_provider.dart';


final startupProvider =
    FutureProvider<void>((ref) async {

  // Keep splash visible for minimum duration
  await Future.delayed(
    const Duration(seconds: 2),
  );


  // Wait until Firebase authentication is ready
  final user =
      await ref.watch(authStateProvider.future);


  // If a user exists,
  // make sure their RiderProfile exists
  if (user != null) {

    await ref.watch(
      currentProfileProvider.future,
    );

  }

});