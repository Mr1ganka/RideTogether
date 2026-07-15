import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/position_entity.dart';
import 'location_permission_provider.dart';
import 'location_repository_provider.dart';


final initialPositionProvider =
    FutureProvider<PositionEntity?>((ref) async {

  //final permission =
    await ref.watch(locationPermissionProvider.future);


  final repository =
      ref.watch(locationRepositoryProvider);


  return repository.getCurrentPosition();
});