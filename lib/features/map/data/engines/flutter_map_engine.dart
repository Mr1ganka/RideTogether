import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ride_together/features/location/presentation/widgets/constants/location_marker_constants.dart';

import '../../domain/engine/map_engine.dart';
import '../../domain/entities/camera_position.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_polyline.dart';
import '../../domain/entities/map_theme.dart';
import '../../domain/entities/user_location_marker.dart' as map_entity;

import '../mappers/flutter_map_mapper.dart';
import '../constants/map_constants.dart';
import 'package:ride_together/features/location/presentation/widgets/user_location_marker.dart'
    as location_widget;

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
    final allMarkers = <MapMarker>[...markers];

    // Add user location marker if available and not already present
    if (userLocationMarker != null && !allMarkers.any((m) => m.id == userLocationMarker.id)) {
      allMarkers.add(
        MapMarker(
          id: userLocationMarker.id,
          position: userLocationMarker.position,
        ),
      );
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: initialCamera.target.toFlutterMapLatLng(),

        initialZoom: initialCamera.zoom,
      ),

      children: [
        TileLayer(
          urlTemplate: theme == MapTheme.dark
              ? MapConstants.darkTileUrl
              : MapConstants.osmTileUrl,

          subdomains: theme == MapTheme.dark
              ? MapConstants.darkSubdomains
              : const [],

          userAgentPackageName: MapConstants.userAgent,
        ),

        MarkerLayer(
          markers: allMarkers.map((marker) {
            // Use custom user location marker for the current user
            if (marker.id == 'current_user' && userLocationMarker != null) {
              return Marker(
                point: marker.position.toFlutterMapLatLng(),
                width: LocationMarkerConstants.markerSize,
                height: LocationMarkerConstants.markerSize,
                alignment: Alignment.center,
                child: location_widget.UserLocationMarker(
                  marker: userLocationMarker,
                  isAnimating: true,
                ),
              );
            }

            // Default marker for other markers
            return Marker(
              point: marker.position.toFlutterMapLatLng(),

              width: 50,

              height: 50,

              child: const Icon(
                Icons.location_pin,
                color: Colors.blue,
                size: 40,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
