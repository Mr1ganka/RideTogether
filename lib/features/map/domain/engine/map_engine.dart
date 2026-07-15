import 'package:flutter/widgets.dart';

import '../entities/camera_position.dart';
import '../entities/map_marker.dart';
import '../entities/map_polyline.dart';


abstract interface class MapEngine {
  Widget buildMap({
    required CameraPosition initialCamera,
    required List<MapMarker> markers,
    required List<MapPolyline> polylines,
    // void Function(GeoPoint point)? onTap,
    // void Function(CameraPosition camera)? onCameraMove,
  });
}