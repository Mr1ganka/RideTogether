import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_together/features/ride/data/models/ride_model.dart';
import 'package:ride_together/features/ride/data/models/rider_location_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';

/// Abstract Remote Data Source interface for Ride data operations.
/// 
/// JAVA ANALOGY:
/// `public interface RideRemoteDataSource`
abstract class RideRemoteDataSource {
  /// Saves a new [RideModel] to the remote database.
  Future<RideModel> createRide(RideModel ride);

  /// Retrieves a single [RideModel] by its unique [rideId].
  Future<RideModel?> getRide(String rideId);

  /// Finds a [RideModel] by its unique 6-character [joinCode].
  Future<RideModel?> getRideByJoinCode(String joinCode);

  /// Real-time stream of a specific [RideModel] by [rideId].
  Stream<RideModel?> watchRide(String rideId);

  /// Real-time stream of the currently active ride for a specific [userId].
  Stream<RideModel?> watchActiveRideForUser(String userId);

  /// Updates an existing [RideModel] in the database.
  Future<void> updateRide(RideModel ride);

  /// Updates only the status string of a ride.
  Future<void> updateRideStatus(String rideId, RideStatus status);

  /// Adds a member to an existing ride document.
  Future<void> updateRideMembers(String rideId, RideModel updatedRide);

  /// Updates live location of a rider in subcollection `rides/{rideId}/locations/{userId}`.
  Future<void> updateRiderLocation(String rideId, RiderLocationModel location);

  /// Stream of all rider live locations in `rides/{rideId}/locations`.
  Stream<List<RiderLocationModel>> watchRideLocations(String rideId);
}

/// Firebase Firestore implementation of [RideRemoteDataSource].
/// 
/// JAVA ANALOGY:
/// `public class FirebaseRideRemoteDataSource implements RideRemoteDataSource`
class FirebaseRideRemoteDataSource implements RideRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseRideRemoteDataSource({required this.firestore});

  /// Collection reference helper (`/rides`)
  CollectionReference<Map<String, dynamic>> get _ridesRef =>
      firestore.collection('rides');

  @override
  Future<RideModel> createRide(RideModel ride) async {
    final map = ride.toMap();
    // Helper array to allow Firestore `arrayContains` queries on member user IDs
    map['memberUserIds'] = ride.members.map((m) => m.rider.id).toList();

    await _ridesRef.doc(ride.id).set(map);
    return ride;
  }

  @override
  Future<RideModel?> getRide(String rideId) async {
    final doc = await _ridesRef.doc(rideId).get();
    if (!doc.exists || doc.data() == null) {
      return null;
    }
    return RideModel.fromMap(doc.data()!, documentId: doc.id);
  }

  @override
  Future<RideModel?> getRideByJoinCode(String joinCode) async {
    final query = await _ridesRef
        .where('joinCode', isEqualTo: joinCode.trim().toUpperCase())
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    final doc = query.docs.first;
    return RideModel.fromMap(doc.data(), documentId: doc.id);
  }

  @override
  Stream<RideModel?> watchRide(String rideId) {
    return _ridesRef.doc(rideId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      }
      return RideModel.fromMap(doc.data()!, documentId: doc.id);
    });
  }

  @override
  Stream<RideModel?> watchActiveRideForUser(String userId) {
    // Watches rides where userId is in memberUserIds array and status is not completed/cancelled
    return _ridesRef
        .where('memberUserIds', arrayContains: userId)
        .where('status', whereIn: [
          RideStatus.planned.name,
          RideStatus.recruiting.name,
          RideStatus.active.name,
          RideStatus.paused.name,
        ])
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) {
            return null;
          }
          // Return the first matching active ride
          final doc = snapshot.docs.first;
          return RideModel.fromMap(doc.data(), documentId: doc.id);
        });
  }

  @override
  Future<void> updateRide(RideModel ride) async {
    final map = ride.toMap();
    map['memberUserIds'] = ride.members.map((m) => m.rider.id).toList();
    await _ridesRef.doc(ride.id).update(map);
  }

  @override
  Future<void> updateRideStatus(String rideId, RideStatus status) async {
    await _ridesRef.doc(rideId).update({
      'status': status.name,
    });
  }

  @override
  Future<void> updateRideMembers(String rideId, RideModel updatedRide) async {
    final map = updatedRide.toMap();
    await _ridesRef.doc(rideId).update({
      'members': map['members'],
      'memberUserIds': updatedRide.members.map((m) => m.rider.id).toList(),
    });
  }

  @override
  Future<void> updateRiderLocation(
    String rideId,
    RiderLocationModel location,
  ) async {
    await _ridesRef
        .doc(rideId)
        .collection('locations')
        .doc(location.userId)
        .set(location.toMap());
  }

  @override
  Stream<List<RiderLocationModel>> watchRideLocations(String rideId) {
    return _ridesRef
        .doc(rideId)
        .collection('locations')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RiderLocationModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}
