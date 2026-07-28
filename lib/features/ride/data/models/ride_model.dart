import 'package:ride_together/features/ride/data/models/ride_member_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';

/// [RideModel] is the Data-layer model representing a group [Ride].
/// It extends [Ride] and handles serialization to/from database maps (Firestore / JSON).
class RideModel extends Ride {
  const RideModel({
    required super.id,
    required super.name,
    super.description,
    required super.joinCode,
    required super.leader,
    required super.status,
    required super.members,
    required super.createdAt,
    super.startAt,
    super.endedAt,
  });

  /// Factory constructor to deserialize a raw database Map (JSON / HashMap) into a [RideModel].
  factory RideModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return RideModel(
      // Firestore document ID takes precedence if passed separately
      id: documentId ?? map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      joinCode: map['joinCode'] as String,
      
      // Deserialize leader nested object using RideMemberModel.fromMap
      leader: RideMemberModel.fromMap(map['leader'] as Map<String, dynamic>),
      
      // Deserialize RideStatus enum string
      status: RideStatus.values.byName(map['status'] as String),
      
      // Deserialize embedded members list
      members: (map['members'] as List<dynamic>)
          .map((m) => RideMemberModel.fromMap(m as Map<String, dynamic>))
          .toList(),
          
      // Parse ISO-8601 strings back into DateTime objects
      createdAt: DateTime.parse(map['createdAt'] as String),
      startAt: map['startAt'] != null
          ? DateTime.parse(map['startAt'] as String)
          : null,
      endedAt: map['endedAt'] != null
          ? DateTime.parse(map['endedAt'] as String)
          : null,
    );
  }

  /// Serializes this [RideModel] into a standard Dart Map (JSON / HashMap) for storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'joinCode': joinCode,
      
      // Convert leader to map
      'leader': leader is RideMemberModel
          ? (leader as RideMemberModel).toMap()
          : RideMemberModel.fromEntity(leader).toMap(),
          
      // Convert enum to string
      'status': status.name,
      
      // Convert list of members to list of maps
      'members': members
          .map(
            (m) => m is RideMemberModel
                ? m.toMap()
                : RideMemberModel.fromEntity(m).toMap(),
          )
          .toList(),
          
      // Convert dates to ISO-8601 strings
      'createdAt': createdAt.toIso8601String(),
      'startAt': startAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
    };
  }

  /// Factory constructor to wrap a domain [Ride] entity as a [RideModel].
  factory RideModel.fromEntity(Ride ride) {
    return RideModel(
      id: ride.id,
      name: ride.name,
      description: ride.description,
      joinCode: ride.joinCode,
      leader: ride.leader,
      status: ride.status,
      members: ride.members,
      createdAt: ride.createdAt,
      startAt: ride.startAt,
      endedAt: ride.endedAt,
    );
  }
}