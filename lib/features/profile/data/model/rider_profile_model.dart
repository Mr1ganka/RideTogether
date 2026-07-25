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
    return RiderProfileModel(
      id: map['id'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoUrl'] as String?,
      createdAt: (map['createdAt'] as dynamic).toDate(),
      updatedAt: (map['updatedAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
