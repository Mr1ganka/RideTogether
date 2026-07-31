import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ride_together/core/theme/app_colors.dart';
import 'package:ride_together/core/theme/app_radius.dart';
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
    if (userLocationMarker != null &&
        !allMarkers.any((m) => m.id == userLocationMarker.id)) {
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

            final markerColor =
                marker.isLeader ? AppColors.leaderMarker : AppColors.participantMarker;

            // Labeled marker for group ride participants
            return Marker(
              point: marker.position.toFlutterMapLatLng(),
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (marker.label != null)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: markerColor,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (marker.isLeader) ...[
                            const Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 2),
                          ],
                          Text(
                            marker.label!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Icon(
                    Icons.navigation,
                    color: markerColor,
                    size: 28,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
