import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/position_entity.dart';
import '../../presentation/providers/location_repository_provider.dart';

final currentPositionProvider =
    StreamProvider<PositionEntity>((ref) {

  final repository =
      ref.watch(locationRepositoryProvider);

  return repository.getPositionStream();

});