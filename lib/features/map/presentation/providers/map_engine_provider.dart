import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/engines/flutter_map_engine.dart';
import '../../domain/engine/map_engine.dart';

final mapEngineProvider = Provider<MapEngine>((ref) {
  return FlutterMapEngine();
});
