import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/app_update_repository.dart';
import '../../domain/models/app_version_info.dart';
import '../../domain/services/app_update_service.dart';
import '../../domain/services/update_decision.dart';

/// Set to true to test the update banner/dialog UI with mock logs before connecting Firestore
const bool useMockUpdateForTesting = false;

final appUpdateRepositoryProvider = Provider<AppUpdateRepository>((ref) {
  return AppUpdateRepository();
});

final appUpdateServiceProvider = Provider<AppUpdateService>((ref) {
  return AppUpdateService();
});

class AppUpdateState {
  final AppVersionInfo? info;
  final UpdateDecision decision;

  const AppUpdateState({this.info, this.decision = UpdateDecision.none});
}

final checkForUpdatesProvider = FutureProvider<AppUpdateState>((ref) async {
  developer.log('🔍 [AppUpdate] Starting update check...', name: 'AppUpdate');

  if (useMockUpdateForTesting) {
    developer.log('⚙️ [AppUpdate] Mock mode active: Simulating 2s version lookup...', name: 'AppUpdate');
    await Future.delayed(const Duration(seconds: 2));

    const mockInfo = AppVersionInfo(
      latestVersion: '1.0.1',
      minSupportedVersion: '1.0.0',
      buildNumber: 2,
      downloadUrl: 'https://github.com/mock/RideTogether/releases/download/v1.0.1/app-release.apk',
      releaseNotes: '• Added new top notch update banner!\n• Performance improvements and bug fixes.',
      updateType: 'optional',
    );

    developer.log('🚀 [AppUpdate] Mock update found: v1.0.1 (Decision: optional)', name: 'AppUpdate');
    return const AppUpdateState(info: mockInfo, decision: UpdateDecision.optional);
  }

  final repository = ref.watch(appUpdateRepositoryProvider);
  final service = ref.watch(appUpdateServiceProvider);

  final info = await repository.fetchLatestVersionInfo();
  if (info == null) {
    developer.log('ℹ️ [AppUpdate] No version document found in Firestore.', name: 'AppUpdate');
    return const AppUpdateState();
  }

  final decision = await service.evaluateUpdate(info);
  developer.log('📋 [AppUpdate] Update evaluation completed: ${decision.name}', name: 'AppUpdate');
  return AppUpdateState(info: info, decision: decision);
});

