import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/core/theme/app_colors.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ride_together/features/location/presentation/providers/current_posisiton_provider.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/map_marker.dart';
import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

const _riderPalette = [
  Color(0xFFE53935), // Crimson Red
  Color(0xFFD81B60), // Vibrant Pink
  Color(0xFF8E24AA), // Deep Purple
  Color(0xFF3949AB), // Indigo
  Color(0xFF00ACC1), // Cyan
  Color(0xFF00897B), // Teal
  Color(0xFF43A047), // Emerald Green
  Color(0xFFFB8C00), // Bright Orange
  Color(0xFFF57C00), // Dark Amber
  Color(0xFF6D4C41), // Copper
];

Color _getRiderColor(String userId, bool isLeader, int memberIndex) {
  if (isLeader) return AppColors.leaderMarker;
  final index = memberIndex >= 0 ? memberIndex : userId.hashCode.abs();
  return _riderPalette[index % _riderPalette.length];
}

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

  Future.microtask(() {
    repository.updateRiderLocation(
      rideId: activeRide.id,
      location: location,
    );
  });
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

    // Find member details and index for distinct color mapping
    RideMember? member;
    int memberIndex = -1;
    for (int i = 0; i < activeRide.members.length; i++) {
      if (activeRide.members[i].rider.id == loc.userId) {
        member = activeRide.members[i];
        memberIndex = i;
        break;
      }
    }
    member ??= activeRide.leader;

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
        heading: loc.heading,
        color: _getRiderColor(loc.userId, isLeader, memberIndex),
      ),
    );
  }

  return markers;
});
