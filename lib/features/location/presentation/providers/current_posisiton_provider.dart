import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/position_entity.dart';
import 'location_repository_provider.dart';
import 'dart:developer' as developer;

final currentPositionProvider = StreamProvider<PositionEntity>((ref) {
  final repository = ref.watch(locationRepositoryProvider);

  return repository.getPositionStream().map((position) {

    developer.log(
      'GPS update: ${position.latitude}, ${position.longitude}',
      name: 'Location',
      level: 800, // INFO
    );

    return position;
  });
});
