import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:ride_together/features/map/domain/entities/map_theme.dart';

import '../../domain/entities/camera_position.dart';
import '../../domain/entities/geo_point.dart';
import '../../domain/entities/map_marker.dart';
import '../../domain/entities/map_polyline.dart';
import '../providers/map_engine_provider.dart';
import '../providers/user_marker_provider.dart';
import '../utils/map_animation_utils.dart';

class AppMap extends ConsumerStatefulWidget {
  const AppMap({
    super.key,
    this.initialCamera,
    this.markers = const [],
    this.polylines = const [],
    required this.mapController,
    this.autoPanOnEdge = true,
  });

  final CameraPosition? initialCamera;
  final List<MapMarker> markers;
  final List<MapPolyline> polylines;
  final MapController mapController;
  final bool autoPanOnEdge;

  @override
  ConsumerState<AppMap> createState() => _AppMapState();
}

class _AppMapState extends ConsumerState<AppMap> with TickerProviderStateMixin {
  bool _isUserGesturing = false;
  Timer? _gestureResetTimer;

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (hasGesture) {
      _isUserGesturing = true;
      _gestureResetTimer?.cancel();
      _gestureResetTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isUserGesturing = false;
          });
          // Immediately check if marker is near edge when 3s gesture cooldown expires
          final userMarker = ref.read(userLocationMarkerProvider);
          if (userMarker != null) {
            final pos = LatLng(
              userMarker.position.latitude,
              userMarker.position.longitude,
            );
            _checkAndPanCamera(pos);
          }
        }
      });
    }
  }

  void _checkAndPanCamera(LatLng markerPos) {
    if (!widget.autoPanOnEdge || _isUserGesturing) return;

    final camera = widget.mapController.camera;
    if (isLatLngNearCameraEdge(camera: camera, point: markerPos)) {
      animatedMapMove(
        mapController: widget.mapController,
        vsync: this,
        destLocation: markerPos,
        destZoom: camera.zoom,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _gestureResetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapEngine = ref.watch(mapEngineProvider);
    final userLocationMarker = ref.watch(userLocationMarkerProvider);

    // Listen for marker updates to perform automatic camera edge-recenter
    ref.listen(userLocationMarkerProvider, (previous, next) {
      if (next != null) {
        final pos = LatLng(next.position.latitude, next.position.longitude);
        _checkAndPanCamera(pos);
      }
    });

    final brightness = Theme.of(context).brightness;
    final mapTheme = brightness == Brightness.dark
        ? MapTheme.dark
        : MapTheme.light;

    return mapEngine.buildMap(
      initialCamera: widget.initialCamera ??
          const CameraPosition(
            target: GeoPoint(latitude: 0, longitude: 0),
            zoom: 2,
          ),
      markers: widget.markers,
      polylines: widget.polylines,
      theme: mapTheme,
      userLocationMarker: userLocationMarker,
      mapController: widget.mapController,
      onPositionChanged: _onPositionChanged,
    );
  }
}
