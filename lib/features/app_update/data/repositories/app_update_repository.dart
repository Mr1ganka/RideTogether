import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_together/features/app_update/domain/models/app_version_info.dart';
import 'dart:developer' as developer;

class AppUpdateRepository {
  final FirebaseFirestore _firestore;

  AppUpdateRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetches latest update metadata from Firestore document at app_config/version
  Future<AppVersionInfo?> fetchLatestVersionInfo() async {
    try {
      final doc = await _firestore
          .collection('app_config')
          .doc('version')
          .get();

      if (doc.exists && doc.data() != null) {
        return AppVersionInfo.fromMap(doc.data()!);
      }
    } catch (e) {
      developer.log(
        'App update unreachable: $e',
        error: e,
        name: 'App Update',
        level: 900, // INFO
      );
    }
    return null;
  }
}
