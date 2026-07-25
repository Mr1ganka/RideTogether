import 'package:flutter/material.dart';

import 'package:ride_together/features/map/domain/entities/user_location_marker.dart'
    as map_entity;

import 'components/accuracy_circle.dart';
import 'components/direction_indicator.dart';
import 'components/location_dot.dart';
import 'constants/location_marker_constants.dart';

class UserLocationMarker extends StatelessWidget {
  final map_entity.UserLocationMarker marker;

  final bool isAnimating;

  const UserLocationMarker({
    super.key,
    required this.marker,
    this.isAnimating = true,
  });

  @override
  Widget build(BuildContext context) {
    // Location accuracy is uncertain / searching if accuracy is null or > 20 meters.
    final isUncertain = marker.accuracy == null || marker.accuracy! > 20.0;

    return SizedBox(
      width: LocationMarkerConstants.markerSize,

      height: LocationMarkerConstants.markerSize,

      child: Stack(
        alignment: Alignment.center,

        clipBehavior: Clip.none,

        children: [
          // Background GPS accuracy visualization (pulses only when trying to find exact position).
          AccuracyCircle(
            radius: _calculateRadius(marker.accuracy ?? 25.0),
            isPulsing: isUncertain,
          ),

          // Direction cone (always visible, Google Maps style >O).
          DirectionIndicator(
            heading: marker.heading ?? 0.0,
            isAnimating: isAnimating,
          ),

          // Top layer.
          //
          // The GPS coordinate is visually anchored
          // here at the center of this widget.
          LocationDot(),
        ],
      ),
    );
  }

  double _calculateRadius(double accuracy) {
    // TODO:
    // Proper accuracy scaling should later use
    // flutter_map projection and current zoom level.

    // final radius = accuracy * LocationMarkerConstants.pixelsPerMeter;

    // return radius.clamp(
    //   LocationMarkerConstants.minAccuracyRadius,

    //   LocationMarkerConstants.maxAccuracyRadius,
    // );
    return 50;
  }
}
