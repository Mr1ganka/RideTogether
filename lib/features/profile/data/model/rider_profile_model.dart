import '../../domain/entities/rider_profile.dart';

class RiderProfileModel extends RiderProfile {
  const RiderProfileModel({
    required super.id,
    required super.displayName,
    super.photoUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RiderProfileModel.fromMap(Map<String, dynamic> map) {
    DateTime parseDate(dynamic value) {
      if (value is DateTime) return value;
      if (value is String) return DateTime.parse(value);
      try {
        return (value as dynamic).toDate() as DateTime;
      } catch (_) {
        return DateTime.now();
      }
    }

    return RiderProfileModel(
      id: map['id'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoUrl'] as String?,
      createdAt: parseDate(map['createdAt']),
      updatedAt: parseDate(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory RiderProfileModel.fromEntity(RiderProfile profile) {
    return RiderProfileModel(
      id: profile.id,
      displayName: profile.displayName,
      photoUrl: profile.photoUrl,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
