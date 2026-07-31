import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ride_together/features/app_update/domain/services/update_decision.dart';
import '../../domain/models/app_version_info.dart';
import '../../domain/services/app_update_service.dart';

class UpdateDialog extends StatefulWidget {
  final AppVersionInfo versionInfo;
  final UpdateDecision decision;
  final AppUpdateService updateService;

  const UpdateDialog({
    super.key,
    required this.versionInfo,
    required this.decision,
    required this.updateService,
  });

  static Future<void> show(
    BuildContext context, {
    required AppVersionInfo versionInfo,
    required UpdateDecision decision,
    required AppUpdateService updateService,
  }) {
    final isMandatory = decision == UpdateDecision.mandatory;
    return showDialog(
      context: context,
      barrierDismissible: !isMandatory,
      builder: (ctx) => UpdateDialog(
        versionInfo: versionInfo,
        decision: decision,
        updateService: updateService,
      ),
    );
  }

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool _isDownloading = false;
  double _progress = 0.0;
  String? _errorMessage;
  StreamSubscription<DownloadProgressEvent>? _subscription;

  bool get _isMandatory => widget.decision == UpdateDecision.mandatory;

  void _startUpdate() {
    setState(() {
      _isDownloading = true;
      _errorMessage = null;
    });

    _subscription = widget.updateService
        .downloadAndInstall(widget.versionInfo.downloadUrl)
        .listen(
      (event) {
        if (event.status == DownloadStatus.downloading) {
          setState(() {
            _progress = event.progress;
          });
        } else if (event.status == DownloadStatus.installing) {
          setState(() {
            _progress = 1.0;
          });
        } else if (event.status == DownloadStatus.error) {
          setState(() {
            _isDownloading = false;
            _errorMessage = 'Download failed: ${event.error}';
          });
        }
      },
      onError: (err) {
        setState(() {
          _isDownloading = false;
          _errorMessage = 'Error downloading update: $err';
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_isMandatory && !_isDownloading,
      child: AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.system_update_rounded, color: theme.colorScheme.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _isMandatory ? 'Update Required' : 'New Update Available',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version ${widget.versionInfo.latestVersion}',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: SingleChildScrollView(
                child: Text(
                  widget.versionInfo.releaseNotes,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
              ),
            ],
            if (_isDownloading) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                'Downloading: ${(_progress * 100).toInt()}%',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        actions: _isDownloading
            ? null
            : [
                if (!_isMandatory)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Later',
                      style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _startUpdate,
                  child: const Text('Update Now'),
                ),
              ],
      ),
    );
  }
}
