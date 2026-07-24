import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/map/domain/entities/map_mode.dart';

final mapModeProvider = StateProvider<MapMode>((ref) {
  return MapMode.idle;
});