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
