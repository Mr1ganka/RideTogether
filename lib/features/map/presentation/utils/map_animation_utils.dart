import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void animatedMapMove({
  required MapController mapController,
  required TickerProvider vsync,
  required LatLng destLocation,
  required double destZoom,
  Duration duration = const Duration(milliseconds: 600),
  Curve curve = Curves.easeInOutCubic,
}) {
  final camera = mapController.camera;
  final startLatLng = camera.center;
  final startZoom = camera.zoom;

  final controller = AnimationController(duration: duration, vsync: vsync);
  final animation = CurvedAnimation(parent: controller, curve: curve);

  controller.addListener(() {
    final progress = animation.value;
    final lat =
        startLatLng.latitude + (destLocation.latitude - startLatLng.latitude) * progress;
    final lng =
        startLatLng.longitude + (destLocation.longitude - startLatLng.longitude) * progress;
    final zoom = startZoom + (destZoom - startZoom) * progress;

    mapController.move(LatLng(lat, lng), zoom);
  });

  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      controller.dispose();
    }
  });

  controller.forward();
}

/// Returns true if [point] is near the edge of the current [camera] viewport,
/// considering the current zoom level and specified [marginRatio].
bool isLatLngNearCameraEdge({
  required MapCamera camera,
  required LatLng point,
  double marginRatio = 0.20,
}) {
  final bounds = camera.visibleBounds;
  final south = bounds.south;
  final north = bounds.north;
  final west = bounds.west;
  final east = bounds.east;

  final latSpan = north - south;
  final lngSpan = east - west;

  // Zoom-adaptive margin calculation:
  // Higher zoom levels have tighter geographical spans, so we use slightly higher margin
  final effectiveMargin = (camera.zoom >= 15.0 ? marginRatio * 1.15 : marginRatio).clamp(0.15, 0.30);

  final safeSouth = south + latSpan * effectiveMargin;
  final safeNorth = north - latSpan * effectiveMargin;
  final safeWest = west + lngSpan * effectiveMargin;
  final safeEast = east - lngSpan * effectiveMargin;

  return point.latitude < safeSouth ||
      point.latitude > safeNorth ||
      point.longitude < safeWest ||
      point.longitude > safeEast;
}

/// Smoothly animates camera to fit [bounds] with padding.
void animatedFitBounds({
  required MapController mapController,
  required TickerProvider vsync,
  required LatLngBounds bounds,
  double padding = 40.0,
  Duration duration = const Duration(milliseconds: 600),
  Curve curve = Curves.easeInOutCubic,
}) {
  final fit = CameraFit.bounds(
    bounds: bounds,
    padding: EdgeInsets.all(padding),
  ).fit(mapController.camera);

  animatedMapMove(
    mapController: mapController,
    vsync: vsync,
    destLocation: fit.center,
    destZoom: fit.zoom,
    duration: duration,
    curve: curve,
  );
}
