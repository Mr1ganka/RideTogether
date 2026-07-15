import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../domain/engine/map_engine.dart';
import '../../domain/entities/camera_position.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_polyline.dart';
import '../../domain/entities/map_theme.dart';

import '../mappers/flutter_map_mapper.dart';
import '../constants/map_constants.dart';

class FlutterMapEngine implements MapEngine {
  @override
  Widget buildMap({
    required CameraPosition initialCamera,
    required List<MapMarker> markers,
    required List<MapPolyline> polylines,
    required MapTheme theme,
  }) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCamera.target.toFlutterMapLatLng(),

        initialZoom: initialCamera.zoom,
      ),

      children: [
        TileLayer(
  urlTemplate:
      theme == MapTheme.dark
          ? MapConstants.darkTileUrl
          : MapConstants.osmTileUrl,

  subdomains:
      theme == MapTheme.dark
          ? MapConstants.darkSubdomains
          : const [],

  userAgentPackageName:
      MapConstants.userAgent,
),

        MarkerLayer(
          markers: markers.map((marker) {
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
