import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/location/presentation/providers/current_posisiton_provider.dart';

import '../../domain/entities/geo_point.dart';
import '../../domain/entities/map_marker.dart';


final userMarkerProvider =
    Provider<MapMarker?>((ref) {

  final position =
      ref.watch(currentPositionProvider).value;


  if (position == null) {
    return null;
  }


  return MapMarker(
    id: 'current_user',

    position: GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    ),
  );

});