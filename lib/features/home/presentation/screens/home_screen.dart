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
import '../../../../features/ride/presentation/providers/ride_location_providers.dart';
import '../../../../features/ride/presentation/widgets/active_ride_panel.dart';
import 'dart:developer' as developer;

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../../../features/location/domain/services/background_location_service.dart';
import '../../../../features/location/presentation/providers/background_consent_provider.dart';
import '../../../../features/location/presentation/widgets/background_consent_sheet.dart';
import '../../../../features/ride/domain/entities/ride.dart';
import '../../../../features/ride/presentation/providers/ride_repository_provider.dart';
import '../../../../features/app_update/presentation/widgets/app_update_checker.dart';
import '../providers/top_notification_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  bool _hasPromptedOnLaunch = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BackgroundLocationService.initService();
      _promptConsentOnAppOpen();
    });
  }

  void _promptConsentOnAppOpen() async {
    final activeRide = ref.read(activeRideProvider).value;
    if (activeRide != null && mounted) {
      _hasPromptedOnLaunch = true;
      ref.read(backgroundConsentProvider.notifier).reset();
      await BackgroundLocationService.stopService();
      if (mounted) {
        BackgroundConsentSheet.show(context);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _promptConsentOnAppOpen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for active ride resolution on cold app launch
    ref.listen<AsyncValue<Ride?>>(activeRideProvider, (previous, next) {
      if (next.value != null && !_hasPromptedOnLaunch && mounted) {
        _promptConsentOnAppOpen();
      }
    });

    // Automatically triggers live location publishing when user is in an active ride
    ref.watch(rideLocationPublisherProvider);

    final mapController = ref.watch(mapControllerProvider);
    final topBannerOffset = ref.watch(topBannerOffsetProvider);
    final topPadding = MediaQuery.of(context).padding.top;

    final activeRideTop = topPadding + (topBannerOffset > 0 ? topBannerOffset + 4.0 : 8.0);

    return AppUpdateChecker(
      child: WithForegroundTask(
        child: Scaffold(
          body: Stack(
            children: [
              HomeMapView(mapController: mapController),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.fastOutSlowIn,
                top: activeRideTop,
                left: 0,
                right: 0,
                child: const ActiveRidePanel(),
              ),
              FloatingMapControls(mapController: mapController),
            ],
          ),
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
      ?userMarker,
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
