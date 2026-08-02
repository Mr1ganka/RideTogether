import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ride_together/features/app_update/domain/models/app_version_info.dart';
import 'package:ride_together/features/app_update/domain/services/update_decision.dart';

enum DownloadStatus { downloading, installing, error }

class DownloadProgressEvent {
  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? error;

  const DownloadProgressEvent({
    required this.status,
    this.progress = 0.0,
    this.error,
  });
}

class AppUpdateService {
  Future<UpdateDecision> evaluateUpdate(AppVersionInfo info) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    final isBelowMin = isVersionOutdated(
      currentVersion,
      info.minSupportedVersion,
    );
    final isBelowLatest = isVersionOutdated(currentVersion, info.latestVersion);

    if (isBelowMin ||
        (isBelowLatest &&
            info.updateType == UpdateDecision.mandatory.value)) {
      return UpdateDecision.mandatory;
    } else if (isBelowLatest) {
      if (info.updateType == UpdateDecision.silent.value) {
        return UpdateDecision.silent;
      } else {
        return UpdateDecision.optional;
      }
    }
    return UpdateDecision.none;
  }

  /// Downloads the APK from GitHub release and triggers Android package installer
  Stream<DownloadProgressEvent> downloadAndInstall(String downloadUrl) async* {
    final client = HttpClient();
    try {
      yield const DownloadProgressEvent(
        status: DownloadStatus.downloading,
        progress: 0.0,
      );

      final request = await client.getUrl(Uri.parse(downloadUrl));
      final response = await request.close();

      if (response.statusCode != 200) {
        yield DownloadProgressEvent(
          status: DownloadStatus.error,
          error: 'HTTP Error ${response.statusCode}',
        );
        return;
      }

      final contentLength = response.contentLength;
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/app-release.apk';
      final file = File(filePath);
      final sink = file.openWrite();

      int downloaded = 0;
      await for (final chunk in response) {
        downloaded += chunk.length;
        sink.add(chunk);
        if (contentLength > 0) {
          yield DownloadProgressEvent(
            status: DownloadStatus.downloading,
            progress: downloaded / contentLength,
          );
        }
      }
      await sink.flush();
      await sink.close();

      yield const DownloadProgressEvent(
        status: DownloadStatus.installing,
        progress: 1.0,
      );

      final result = await OpenFilex.open(
        filePath,
        type: 'application/vnd.android.package-archive',
      );

      if (result.type != ResultType.done) {
        yield DownloadProgressEvent(
          status: DownloadStatus.error,
          error: result.message,
        );
      }
    } catch (e) {
      yield DownloadProgressEvent(
        status: DownloadStatus.error,
        error: e.toString(),
      );
    } finally {
      client.close();
    }
  }

  bool isVersionOutdated(String current, String target) {
    List<int> parse(String v) =>
        v.split('+')[0].split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final cList = parse(current);
    final tList = parse(target);

    for (int i = 0; i < max(cList.length, tList.length); i++) {
      final c = i < cList.length ? cList[i] : 0;
      final t = i < tList.length ? tList[i] : 0;
      if (c < t) return true;
      if (c > t) return false;
    }
    return false;
  }
}

