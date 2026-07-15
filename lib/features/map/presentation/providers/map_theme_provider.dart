import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/map_theme.dart';


final mapThemeProvider = Provider<MapTheme>((ref) {

  return MapTheme.light;

});