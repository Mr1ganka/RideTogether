import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ride_together/features/location/presentation/widgets/constants/location_marker_constants.dart';
import 'package:ride_together/features/location/presentation/widgets/user_location_marker.dart'
    as location_widget;

import '../../domain/entities/map_marker.dart';
import '../../domain/entities/user_location_marker.dart' as map_entity;
import '../../data/mappers/flutter_map_mapper.dart';

class SmoothMarkerLayer extends StatefulWidget {
  final List<MapMarker> markers;
  final map_entity.UserLocationMarker? userLocationMarker;
  final Duration animationDuration;
  final Curve animationCurve;

  const SmoothMarkerLayer({
    super.key,
    required this.markers,
    this.userLocationMarker,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOutCubic,
  });

  @override
  State<SmoothMarkerLayer> createState() => _SmoothMarkerLayerState();
}

class _SmoothMarkerLayerState extends State<SmoothMarkerLayer>
    with TickerProviderStateMixin {
  final Map<String, LatLng> _animatedPositions = {};
  final Map<String, LatLng> _startPositions = {};
  final Map<String, LatLng> _targetPositions = {};
  final Map<String, AnimationController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _updatePositions(isInitial: true);
  }

  @override
  void didUpdateWidget(SmoothMarkerLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updatePositions(isInitial: false);
  }

  void _updatePositions({required bool isInitial}) {
    final allMarkers = <MapMarker>[...widget.markers];

    if (widget.userLocationMarker != null &&
        !allMarkers.any((m) => m.id == widget.userLocationMarker!.id)) {
      allMarkers.add(
        MapMarker(
          id: widget.userLocationMarker!.id,
          position: widget.userLocationMarker!.position,
        ),
      );
    }

    final activeIds = <String>{};

    for (final marker in allMarkers) {
      final id = marker.id;
      activeIds.add(id);
      final target = marker.position.toFlutterMapLatLng();

      if (isInitial || !_animatedPositions.containsKey(id)) {
        _animatedPositions[id] = target;
        _targetPositions[id] = target;
      } else {
        final currentTarget = _targetPositions[id];
        if (currentTarget != target) {
          final currentAnimated = _animatedPositions[id] ?? target;

          // If distance is huge (> ~50km), snap immediately instead of animating
          final distance = const Distance().distance(currentAnimated, target);
          if (distance > 50000) {
            _animatedPositions[id] = target;
            _targetPositions[id] = target;
          } else {
            _startPositions[id] = currentAnimated;
            _targetPositions[id] = target;

            var controller = _controllers[id];
            if (controller == null) {
              controller = AnimationController(
                vsync: this,
                duration: widget.animationDuration,
              );
              _controllers[id] = controller;
            } else {
              controller.stop();
              controller.duration = widget.animationDuration;
            }

            final curvedAnimation = CurvedAnimation(
              parent: controller,
              curve: widget.animationCurve,
            );

            void listener() {
              if (!mounted) return;
              final t = curvedAnimation.value;
              final start = _startPositions[id]!;
              final end = _targetPositions[id]!;
              final lat = lerpDouble(start.latitude, end.latitude, t)!;
              final lng = lerpDouble(start.longitude, end.longitude, t)!;
              setState(() {
                _animatedPositions[id] = LatLng(lat, lng);
              });
            }

            controller.removeListener(listener);
            controller.addListener(listener);
            controller.forward(from: 0.0);
          }
        }
      }
    }

    // Cleanup controllers for removed markers
    final removedIds = _controllers.keys.where((id) => !activeIds.contains(id)).toList();
    for (final id in removedIds) {
      _controllers[id]?.dispose();
      _controllers.remove(id);
      _animatedPositions.remove(id);
      _startPositions.remove(id);
      _targetPositions.remove(id);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allMarkers = <MapMarker>[...widget.markers];

    if (widget.userLocationMarker != null &&
        !allMarkers.any((m) => m.id == widget.userLocationMarker!.id)) {
      allMarkers.add(
        MapMarker(
          id: widget.userLocationMarker!.id,
          position: widget.userLocationMarker!.position,
        ),
      );
    }

    final flutterMapMarkers = allMarkers.map((marker) {
      final point = _animatedPositions[marker.id] ?? marker.position.toFlutterMapLatLng();

      if (marker.id == 'current_user' && widget.userLocationMarker != null) {
        return Marker(
          point: point,
          width: LocationMarkerConstants.markerSize,
          height: LocationMarkerConstants.markerSize,
          alignment: Alignment.center,
          child: location_widget.UserLocationMarker(
            marker: widget.userLocationMarker!,
            isAnimating: true,
          ),
        );
      }

      return Marker(
        point: point,
        width: 48,
        height: 48,
        alignment: Alignment.topCenter,
        child: _buildDefaultMarkerPin(context),
      );
    }).toList();

    return MarkerLayer(markers: flutterMapMarkers);
  }

  Widget _buildDefaultMarkerPin(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: const Icon(
        Icons.location_on_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
