import 'package:ride_together/features/profile/data/model/rider_profile_model.dart';
import 'package:ride_together/features/ride/domain/entities/ride_member.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';

/// [RideMemberModel] is the Data-layer representation of a [RideMember].
/// 
/// JAVA ANALOGY:
/// In Java: `public class RideMemberModel extends RideMember`
/// 
/// Why do we extend [RideMember]?
/// In Clean Architecture, the Domain layer defines pure business entities ([RideMember]).
/// The Data layer extends these entities to add database-specific serialization logic ([fromMap] & [toMap])
/// without cluttering the pure domain entity with database code.
class RideMemberModel extends RideMember {
  /// Constructor passing parameters directly to superclass constructor.
  /// 
  /// JAVA ANALOGY:
  /// In Java, you would write:
  /// `public RideMemberModel(RiderProfile rider, RiderRole role, Date joinedAt, Date completedAt) {`
  /// `    super(rider, role, joinedAt, completedAt);`
  /// `}`
  /// 
  /// In modern Dart (2.17+), `super.rider` is a shorthand for passing arguments directly to the superclass constructor.
  const RideMemberModel({
    required super.rider,
    required super.role,
    required super.joinedAt,
    super.completedAt,
  });

  /// Factory constructor to create a [RideMemberModel] from a raw Map (JSON / HashMap).
  /// 
  /// JAVA ANALOGY:
  /// In Java, this is equivalent to a static factory method:
  /// `public static RideMemberModel fromMap(Map<String, Object> map)`
  /// 
  /// In Dart, `factory` constructors act like static methods that return an instance of the class,
  /// but they use constructor syntax (`RideMemberModel.fromMap(...)`).
  factory RideMemberModel.fromMap(Map<String, dynamic> map) {
    return RideMemberModel(
      // Deserialize nested RiderProfile map into RiderProfileModel
      rider: RiderProfileModel.fromMap(map['rider'] as Map<String, dynamic>),
      
      // Convert String stored in map back to Dart enum (Java equivalent: RiderRole.valueOf(str))
      role: RiderRole.values.byName(map['role'] as String),
      
      // Parse ISO-8601 date string back into Dart DateTime object (Java equivalent: Instant.parse(str))
      joinedAt: DateTime.parse(map['joinedAt'] as String),
      
      // Handle optional/nullable completedAt field
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
    );
  }

  /// Converts this [RideMemberModel] instance into a Dart Map (JSON / HashMap).
  /// 
  /// JAVA ANALOGY:
  /// In Java, this is equivalent to:
  /// `public Map<String, Object> toMap()`
  Map<String, dynamic> toMap() {
    return {
      // If rider is already a RiderProfileModel, call toMap(), otherwise wrap it
      'rider': rider is RiderProfileModel
          ? (rider as RiderProfileModel).toMap()
          : RiderProfileModel.fromEntity(rider).toMap(),
      
      // Store enum as its string name (e.g. "leader", "rider")
      'role': role.name,
      
      // Store dates as standard ISO-8601 strings (e.g. "2026-07-28T00:32:40.000Z")
      'joinedAt': joinedAt.toIso8601String(),
      
      // Call toIso8601String() only if completedAt is non-null
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  /// Converts a pure domain entity ([RideMember]) into a data model ([RideMemberModel]).
  factory RideMemberModel.fromEntity(RideMember member) {
    return RideMemberModel(
      rider: member.rider,
      role: member.role,
      joinedAt: member.joinedAt,
      completedAt: member.completedAt,
    );
  }
}
