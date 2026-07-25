import '../entities/position_entity.dart';
import '../entities/permission_status_entity.dart';

abstract class LocationRepository {
  Future<PositionEntity?> getCurrentPosition();
  Stream<PositionEntity> getPositionStream();
  Future<PermissionStatusEntity> requestPermission();
  Future<PermissionStatusEntity> checkPermission();
}
