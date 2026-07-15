import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/geolocator_location_repositories.dart';
import '../../domain/repositories/location_repository.dart';


final locationRepositoryProvider =
    Provider<LocationRepository>((ref) {

  return GeolocatorLocationRepository();

});