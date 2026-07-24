import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/map/domain/entities/map_theme.dart';

import '../../domain/entities/camera_position.dart';
import '../../domain/entities/geo_point.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_polyline.dart';
import '../providers/map_engine_provider.dart';
import '../providers/user_marker_provider.dart';

class AppMap extends ConsumerWidget {

  const AppMap({
    super.key,
    this.initialCamera,
    this.markers = const [],
    this.polylines = const [],
    required this.mapController,
  });


  final CameraPosition? initialCamera;

  final List<MapMarker> markers;

  final List<MapPolyline> polylines;

  final MapController mapController;

@override
Widget build(BuildContext context, WidgetRef ref) {

  final mapEngine =
      ref.watch(mapEngineProvider);

  final userLocationMarker =
      ref.watch(userLocationMarkerProvider);


  final brightness =
      Theme.of(context).brightness;


  final mapTheme =
      brightness == Brightness.dark
          ? MapTheme.dark
          : MapTheme.light;


  return mapEngine.buildMap(
    initialCamera:
        initialCamera ??
        const CameraPosition(
          target: GeoPoint(
            latitude: 0,
            longitude: 0,
          ),
          zoom: 2,
        ),

    markers: markers,

    polylines: polylines,

    theme: mapTheme,
    userLocationMarker: userLocationMarker,
    mapController: mapController,
    );
  }
}
