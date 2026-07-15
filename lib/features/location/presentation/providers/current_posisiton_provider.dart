import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/position_entity.dart';
import 'location_repository_provider.dart';


final currentPositionProvider =
    StreamProvider<PositionEntity>((ref) {

  final repository =
      ref.watch(locationRepositoryProvider);


  return repository.getPositionStream()
      .map((position) {

        debugPrint(
          'GPS update: ${position.latitude}, ${position.longitude}',
        );

        return position;
      });

});