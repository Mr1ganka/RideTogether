import 'package:flutter/material.dart';
import 'geo_point.dart';

class MapMarker {
  final String id;
  final GeoPoint position;
  final String? label;
  final bool isLeader;
  final double? heading;
  final Color? color;

  const MapMarker({
    required this.id,
    required this.position,
    this.label,
    this.isLeader = false,
    this.heading,
    this.color,
  });
}
