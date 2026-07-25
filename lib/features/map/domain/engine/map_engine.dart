import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ride_together/features/map/domain/entities/map_theme.dart';

import '../entities/camera_position.dart';
import '../entities/map_marker.dart';
import '../entities/map_polyline.dart';
import '../entities/user_location_marker.dart';

abstract interface class MapEngine {
  Widget buildMap({
    required CameraPosition initialCamera,
    required List<MapMarker> markers,
    required List<MapPolyline> polylines,
    required MapTheme theme,
    UserLocationMarker? userLocationMarker,
    MapController? mapController,
  });
}
