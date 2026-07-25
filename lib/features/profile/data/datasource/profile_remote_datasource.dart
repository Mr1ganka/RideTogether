import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/rider_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<RiderProfileModel?> getProfile(String userId);

  Future<void> createProfile(RiderProfileModel profile);

  Future<void> updateProfile(RiderProfileModel profile);
}

class FirebaseProfileRemoteDataSource implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseProfileRemoteDataSource({required this.firestore});

  @override
  Future<RiderProfileModel?> getProfile(String userId) async {
    final document = await firestore.collection('users').doc(userId).get();

    if (!document.exists) {
      return null;
    }

    return RiderProfileModel.fromMap(document.data()!);
  }

  @override
  Future<void> createProfile(RiderProfileModel profile) async {
    await firestore.collection('users').doc(profile.id).set(profile.toMap());
  }

  @override
  Future<void> updateProfile(RiderProfileModel profile) async {
    await firestore.collection('users').doc(profile.id).update(profile.toMap());
  }
}
