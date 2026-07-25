import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/profile_remote_datasource.dart';
import '../../data/repositories/firebase_profile_repository.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  return FirebaseProfileRemoteDataSource(firestore: FirebaseFirestore.instance);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return FirebaseProfileRepository(
    remoteDataSource: ref.read(profileRemoteDataSourceProvider),
  );
});
