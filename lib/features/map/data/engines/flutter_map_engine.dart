import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ride_together/features/map/presentation/widgets/smooth_marker_layer.dart';

import '../../domain/engine/map_engine.dart';
import '../../domain/entities/camera_position.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_polyline.dart';
import '../../domain/entities/map_theme.dart';
import '../../domain/entities/user_location_marker.dart' as map_entity;

import '../mappers/flutter_map_mapper.dart';
import '../constants/map_constants.dart';

class FlutterMapEngine implements MapEngine {
  @override
  Widget buildMap({
    required CameraPosition initialCamera,
    required List<MapMarker> markers,
    required List<MapPolyline> polylines,
    required MapTheme theme,
    map_entity.UserLocationMarker? userLocationMarker,
    MapController? mapController,
  }) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCamera.target.toFlutterMapLatLng(),
        initialZoom: initialCamera.zoom,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: theme == MapTheme.dark
              ? MapConstants.darkTileUrl
              : MapConstants.osmTileUrl,
          subdomains: MapConstants.subdomains,
          userAgentPackageName: MapConstants.userAgent,
        ),

        // Route Polylines
        if (polylines.isNotEmpty) ...[
          // Background casing for polylines (drop-shadow depth)
          PolylineLayer(
            polylines: polylines.map((poly) {
              return Polyline(
                points: poly.points.map((p) => p.toFlutterMapLatLng()).toList(),
                strokeWidth: 8.0,
                color: Colors.black.withValues(alpha: 0.2),
                strokeCap: StrokeCap.round,
                strokeJoin: StrokeJoin.round,
              );
            }).toList(),
          ),
          // Main polyline layer
          PolylineLayer(
            polylines: polylines.map((poly) {
              return Polyline(
                points: poly.points.map((p) => p.toFlutterMapLatLng()).toList(),
                strokeWidth: 5.0,
                color: const Color(0xFF1A73E8),
                strokeCap: StrokeCap.round,
                strokeJoin: StrokeJoin.round,
              );
            }).toList(),
          ),
        ],

        // Smooth animated marker layer
        SmoothMarkerLayer(
          markers: markers,
          userLocationMarker: userLocationMarker,
        ),
      ],
    );
  }
}
