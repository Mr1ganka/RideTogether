import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ride_together/features/location/presentation/providers/current_posisiton_provider.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/map_marker.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

/// Provider streaming live locations for all riders in the active group ride.
final groupRiderLocationsProvider = StreamProvider<List<RiderLocation>>((ref) {
  final activeRide = ref.watch(activeRideProvider).value;
  if (activeRide == null) {
    return Stream.value([]);
  }

  final repository = ref.watch(rideRepositoryProvider);
  return repository.watchRideLocations(activeRide.id);
});

/// Listener provider that automatically publishes local user's GPS updates to Firestore
/// when currently in an active ride.
final rideLocationPublisherProvider = Provider<void>((ref) {
  final activeRide = ref.watch(activeRideProvider).value;
  final position = ref.watch(currentPositionProvider).value;
  final currentUser = ref.watch(authStateProvider).value;

  if (activeRide == null || position == null || currentUser == null) {
    return;
  }

  final repository = ref.read(rideRepositoryProvider);
  final location = RiderLocation(
    userId: currentUser.id,
    latitude: position.latitude,
    longitude: position.longitude,
    heading: position.heading,
    speed: position.speed,
    updatedAt: DateTime.now(),
  );

  repository.updateRiderLocation(
    rideId: activeRide.id,
    location: location,
  );
});

/// Provider transforming group rider locations into map markers for rendering on AppMap.
final groupRiderMarkersProvider = Provider<List<MapMarker>>((ref) {
  final activeRide = ref.watch(activeRideProvider).value;
  final locations = ref.watch(groupRiderLocationsProvider).value ?? [];
  final currentUser = ref.watch(authStateProvider).value;

  if (activeRide == null || locations.isEmpty) {
    return [];
  }

  final currentUserId = currentUser?.id;
  final markers = <MapMarker>[];

  for (final loc in locations) {
    // Skip rendering local user here as local user has dedicated high-res userMarkerProvider
    if (loc.userId == currentUserId) continue;

    // Find member details
    final member = activeRide.members.firstWhere(
      (m) => m.rider.id == loc.userId,
      orElse: () => activeRide.leader,
    );

    final isLeader = member.role == RiderRole.leader;
    final displayName = member.rider.displayName;

    markers.add(
      MapMarker(
        id: 'rider_marker_${loc.userId}',
        position: GeoPoint(
          latitude: loc.latitude,
          longitude: loc.longitude,
        ),
        label: displayName,
        isLeader: isLeader,
      ),
    );
  }

  return markers;
});
