import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';

abstract class RideRepository {
  Future<Ride> createRide({
    required String name,
    String? description,
    String? customJoinCode,
  });

  Future<Ride> joinRideByCode(String joinCode);

  Future<Ride?> getRide(String rideId);

  Stream<Ride?> watchRide(String rideId);

  Stream<Ride?> watchActiveRide();

  Future<void> updateRideStatus({
    required String rideId,
    required RideStatus status,
  });

  Future<void> leaveRide(String rideId);

  Future<void> updateRiderLocation({
    required String rideId,
    required RiderLocation location,
  });

  Stream<List<RiderLocation>> watchRideLocations(String rideId);
}