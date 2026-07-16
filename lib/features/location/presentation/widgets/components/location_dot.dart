import 'package:flutter/material.dart';

import '../constants/location_marker_constants.dart';

class LocationDot extends StatelessWidget {
  const LocationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft shadow behind the marker.
          Container(
            width: LocationMarkerConstants.shadowSize,

            height: LocationMarkerConstants.shadowSize,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),

                  blurRadius: 8,

                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),

          // White navigation marker ring.
          Container(
            width: LocationMarkerConstants.outerRingSize,

            height: LocationMarkerConstants.outerRingSize,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,

              color: Colors.white,
            ),
          ),

          // Blue GPS position dot.
          Container(
            width: LocationMarkerConstants.innerDotSize,

            height: LocationMarkerConstants.innerDotSize,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: LocationMarkerConstants.dotBlue,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),

                  blurRadius: 3,

                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
