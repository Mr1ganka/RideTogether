import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/permission_status_entity.dart';
import 'location_repository_provider.dart';

final locationPermissionProvider = AsyncNotifierProvider<
    LocationPermissionNotifier,
    PermissionStatusEntity>(
  LocationPermissionNotifier.new,
);

class LocationPermissionNotifier
    extends AsyncNotifier<PermissionStatusEntity> {

  @override
  Future<PermissionStatusEntity> build() async {
    final repository = ref.read(locationRepositoryProvider);

    return repository.checkPermission();
  }

  Future<PermissionStatusEntity> requestPermission() async {
    state = const AsyncLoading();

    final repository =
        ref.read(locationRepositoryProvider);

    final result = await repository.requestPermission();

    state = AsyncValue.data(result);

    return result;
  }

  Future<void> refreshPermission() async {
    state = const AsyncLoading();

    final repository = ref.read(locationRepositoryProvider);

    state = await AsyncValue.guard(
      repository.checkPermission,
    );
  }
}