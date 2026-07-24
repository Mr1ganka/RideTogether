import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/permission_status_entity.dart';
import 'location_repository_provider.dart';

final locationPermissionProvider =
    AsyncNotifierProvider<LocationPermissionNotifier, PermissionStatusEntity>(
      LocationPermissionNotifier.new,
    );

class LocationPermissionNotifier extends AsyncNotifier<PermissionStatusEntity> {
  bool hasRequestedPermission = false;

  @override
  Future<PermissionStatusEntity> build() async {
    final repository = ref.read(locationRepositoryProvider);

    return repository.checkPermission();
  }

  Future<PermissionStatusEntity> requestPermission() async {
    state = const AsyncLoading();

    hasRequestedPermission = true;

    final repository = ref.read(locationRepositoryProvider);

    final result = await repository.requestPermission();

    state = AsyncData(result);

    return result;
  }

  Future<PermissionStatusEntity> refreshPermission() async {
    final repository = ref.read(locationRepositoryProvider);

    final result = await repository.checkPermission();

    state = AsyncData(result);

    return result;
  }

  Future<PermissionStatusEntity> ensurePermissionGranted() async {
    final repository = ref.read(locationRepositoryProvider);

    var status = await repository.checkPermission();

    if (status == PermissionStatusEntity.denied) {
      status = await repository.requestPermission();
    }

    state = AsyncData(status);

    return status;
  }

  bool get isPermanentlyDenied {
    return state.value == PermissionStatusEntity.permanentlyDenied;
  }

  bool get shouldOpenSettings {
  return hasRequestedPermission &&
      state.value == PermissionStatusEntity.denied;
}

}
