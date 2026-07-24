import '../../../location/domain/entities/permission_status_entity.dart';

sealed class StartupResult {
  const StartupResult();
}

class StartupReady extends StartupResult {
  const StartupReady();
}

class StartupLocationRequired extends StartupResult {
  final PermissionStatusEntity status;

  const StartupLocationRequired(this.status);
}
