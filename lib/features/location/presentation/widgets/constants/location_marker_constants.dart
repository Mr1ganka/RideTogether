import 'package:flutter/material.dart';

abstract final class LocationMarkerConstants {
  // Marker canvas size.
  static const double markerSize = 80;

  // Accuracy circle.
  static const double minAccuracyRadius = 4;
  static const double maxAccuracyRadius = 100;
  static const double pixelsPerMeter = 1.5;

  // Accuracy pulse.
  static const Duration accuracyPulseDuration = Duration(milliseconds: 1800);

  static const double accuracyMinScale = 0.8;
  static const double accuracyMaxScale = 1.2;

  static const double accuracyMinOpacity = 0.15;
  static const double accuracyMaxOpacity = 0.35;

  static const Color accuracyColor = Color(0xFF4285F4);

  // Location dot.
  static const double shadowSize = 26;
  static const double outerRingSize = 24;
  static const double innerDotSize = 18;

  static const Color dotBlue = Color(0xFF1A73E8);

  static const Duration headingAnimationDuration = Duration(milliseconds: 120);

  static const Curve headingAnimationCurve = Curves.easeOutCubic;

  // Direction cone.
  static const double coneCanvasSize = 60;

  static const Color coneBlue = Color(0xFF1A73E8);
}
