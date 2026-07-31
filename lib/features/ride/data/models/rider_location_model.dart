import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_together/features/ride/domain/entities/rider_location.dart';

class RiderLocationModel extends RiderLocation {
  const RiderLocationModel({
    required super.userId,
    required super.latitude,
    required super.longitude,
    super.heading,
    super.speed,
    required super.updatedAt,
  });

  factory RiderLocationModel.fromEntity(RiderLocation entity) {
    return RiderLocationModel(
      userId: entity.userId,
      latitude: entity.latitude,
      longitude: entity.longitude,
      heading: entity.heading,
      speed: entity.speed,
      updatedAt: entity.updatedAt,
    );
  }

  factory RiderLocationModel.fromMap(Map<String, dynamic> map, String docId) {
    DateTime parseDateTime(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      } else if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return DateTime.now();
    }

    return RiderLocationModel(
      userId: docId,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      heading: map['heading'] != null ? (map['heading'] as num).toDouble() : null,
      speed: map['speed'] != null ? (map['speed'] as num).toDouble() : null,
      updatedAt: parseDateTime(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'heading': heading,
      'speed': speed,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
