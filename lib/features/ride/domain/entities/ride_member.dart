import 'package:ride_together/features/profile/domain/entities/rider_profile.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

// TODO: Currently embedding full RiderProfile object inside RideMember. In post-MVP, decouple this to reference `riderId` and fetch/stream profiles dynamically if real-time profile updates are required.
class RideMember {
  final RiderProfile rider;
  final RiderRole role;
  final DateTime joinedAt;
  final DateTime? completedAt;

  const RideMember({
    required this.rider,
    required this.role,
    required this.joinedAt,
    this.completedAt,
  });

  RideMember copyWith({
    RiderProfile? rider,
    RiderRole? role,
    DateTime? joinedAt,
    DateTime? completedAt,
  }) {
    return RideMember(
      rider: rider ?? this.rider,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
