import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/map/presentation/providers/user_marker_provider.dart';

import '../../../../features/location/presentation/providers/initial_position_provider.dart';

import '../../../../features/map/domain/entities/camera_position.dart';
import '../../../../features/map/domain/entities/geo_point.dart';
import '../../../../features/map/presentation/providers/map_controller_provider.dart';
import '../../../../features/map/presentation/widgets/app_map.dart';
import '../../../../features/map/presentation/widgets/floating_map_controls.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          _buildMap(mapController),
          FloatingMapControls(mapController: mapController),
        ],
      ),
    );
  }

  Widget _buildMap(MapController mapController) {
    final position = ref.watch(initialPositionProvider);

    final marker = ref.watch(userMarkerProvider);

    return position.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },

      error: (error, stack) {
        debugPrint(error.toString());

        return const Center(child: Text('Unable to get location'));
      },

      data: (location) {
        if (location == null) {
          return AppMap(mapController: mapController);
        }

        final userLocation = GeoPoint(
          latitude: location.latitude,
          longitude: location.longitude,
        );

        return AppMap(
          mapController: mapController,
          initialCamera: CameraPosition(target: userLocation, zoom: 15),

          markers: marker == null ? [] : [marker],
        );
      },
    );
  }
}
