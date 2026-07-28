import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';

// TODO: Currently using an embedded list for members in the ride document. Will migrate to a separate Firestore subcollection (`rides/{rideId}/members`) in post-MVP.
class Ride {
  final String id;
  final String name;
  final String? description;
  final String joinCode;
  final RideMember leader;
  final RideStatus status;
  final List<RideMember> members;
  final DateTime createdAt;
  final DateTime? startAt;
  final DateTime? endedAt;

  const Ride({
    required this.id,
    required this.name,
    this.description,
    required this.joinCode,
    required this.leader,
    required this.status,
    required this.members,
    required this.createdAt,
    this.startAt,
    this.endedAt,
  });

  Ride copyWith({
    String? id,
    String? name,
    String? description,
    String? joinCode,
    RideMember? leader,
    RideStatus? status,
    List<RideMember>? members,
    DateTime? createdAt,
    DateTime? startAt,
    DateTime? endedAt,
  }) {
    return Ride(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      joinCode: joinCode ?? this.joinCode,
      leader: leader ?? this.leader,
      status: status ?? this.status,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      startAt: startAt ?? this.startAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  bool get isJoinable =>
      status != RideStatus.completed &&
      status != RideStatus.cancelled;
  bool get isActive =>
      status == RideStatus.active || status == RideStatus.paused;
  RideMember get getLeader => leader;
}

