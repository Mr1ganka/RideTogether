import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/map/presentation/providers/user_marker_provider.dart';

import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';

import '../../../../features/location/presentation/providers/initial_position_provider.dart';
import '../../../../features/location/presentation/providers/location_permission_provider.dart';

import '../../../../features/map/domain/entities/camera_position.dart';
import '../../../../features/map/domain/entities/geo_point.dart';
import '../../../../features/map/presentation/widgets/app_map.dart';
// import '../../../../features/map/domain/entities/map_marker.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(locationPermissionProvider.notifier).requestPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideTogether'),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              final repository = ref.read(authRepositoryProvider);

              await repository.signOut();
            },
          ),
        ],
      ),

      body: _buildMap(),
    );
  }

  Widget _buildMap() {
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
          return const AppMap();
        }

        final userLocation = GeoPoint(
          latitude: location.latitude,
          longitude: location.longitude,
        );

        return AppMap(
          initialCamera: CameraPosition(target: userLocation, zoom: 15),

          markers: marker == null ? [] : [marker],
        );
      },
    );
  }
}
