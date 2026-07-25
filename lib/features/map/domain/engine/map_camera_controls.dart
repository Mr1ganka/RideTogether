import '../entities/camera_position.dart';
import '../entities/map_bounds.dart';

abstract interface class MapCameraController {
  Future<void> moveCamera(CameraPosition position);
  Future<void> zoomIn();
  Future<void> zoomOut();
  Future<void> fitBounds(MapBounds bounds);
}
