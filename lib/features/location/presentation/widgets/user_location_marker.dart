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
    return SizedBox(
      width: LocationMarkerConstants.markerSize,

      height: LocationMarkerConstants.markerSize,

      child: Stack(
        alignment: Alignment.center,

        clipBehavior: Clip.none,

        children: [
          // Background GPS accuracy visualization.
          if (marker.accuracy != null && marker.accuracy! > 0)
            AccuracyCircle(radius: _calculateRadius(marker.accuracy!)),

          // Direction cone.
          //
          // IMPORTANT:
          // This is intentionally BELOW LocationDot.
          //
          // The blue dot hides the cone base,
          // creating the integrated navigation marker look.
          if (marker.heading != null)
            DirectionIndicator(
              heading: marker.heading!,

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
