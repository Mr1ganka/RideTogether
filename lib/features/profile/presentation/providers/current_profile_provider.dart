import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../domain/entities/rider_profile.dart';
import '../../domain/mappers/rider_profile_mapper.dart';
import 'profile_repository_provider.dart';

final currentProfileProvider = FutureProvider<RiderProfile?>((ref) async {
  final authUser = await ref.watch(authStateProvider.future);

  if (authUser == null) {
    return null;
  }

  final repository = ref.read(profileRepositoryProvider);

  final existingProfile = await repository.getProfile(authUser.id);

  if (existingProfile != null) {
    return existingProfile;
  }

  final newProfile = RiderProfileMapper.fromAppUser(authUser);

  await repository.createProfile(newProfile);

  return newProfile;
});
