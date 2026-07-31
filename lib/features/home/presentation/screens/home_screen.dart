import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/map/presentation/providers/user_marker_provider.dart';

import '../../../../features/location/presentation/providers/initial_position_provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../features/map/domain/entities/camera_position.dart';
import '../../../../features/map/domain/entities/geo_point.dart';
import '../../../../features/map/presentation/providers/map_controller_provider.dart';
import '../../../../features/map/presentation/widgets/app_map.dart';
import '../../../../features/map/presentation/widgets/floating_map_controls.dart';
import '../../../../features/ride/presentation/providers/ride_location_providers.dart';
import '../../../../features/ride/presentation/widgets/active_ride_panel.dart';
import 'dart:developer' as developer;

import '../../../../features/app_update/presentation/widgets/app_update_checker.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Automatically triggers live location publishing when user is in an active ride
    ref.watch(rideLocationPublisherProvider);

    final mapController = ref.watch(mapControllerProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    return AppUpdateChecker(
      child: Scaffold(
        body: Stack(
          children: [
            HomeMapView(mapController: mapController),
            Positioned(
              top: topPadding + AppSpacing.sm,
              left: 0,
              right: 0,
              child: const ActiveRidePanel(),
            ),
            FloatingMapControls(mapController: mapController),
          ],
        ),
      ),
    );
  }
}

class HomeMapView extends ConsumerWidget {
  const HomeMapView({required this.mapController, super.key});

  final MapController mapController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(initialPositionProvider);
    final userMarker = ref.watch(userMarkerProvider);
    final groupMarkers = ref.watch(groupRiderMarkersProvider);

    final allMarkers = [
      if (userMarker != null) userMarker,
      ...groupMarkers,
    ];

    return position.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        developer.log(
          error.toString(),
          error: error,
          stackTrace: stack,
          name: 'HomeScreen',
          level: 1000
        );
        return const Center(child: Text('Unable to get location'));
      },
      data: (location) {
        if (location == null) {
          return AppMap(
            mapController: mapController,
            markers: allMarkers,
          );
        }

        final userLocation = GeoPoint(
          latitude: location.latitude,
          longitude: location.longitude,
        );

        return AppMap(
          mapController: mapController,
          initialCamera: CameraPosition(target: userLocation, zoom: 15),
          markers: allMarkers,
        );
      },
    );
  }
}
