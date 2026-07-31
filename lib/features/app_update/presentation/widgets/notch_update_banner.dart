import 'dart:developer' as developer;
import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/models/app_version_info.dart';
import '../../domain/services/app_update_service.dart';
import '../../domain/services/update_decision.dart';
import 'update_dialog.dart';

class NotchUpdateBanner extends StatefulWidget {
  final AppVersionInfo versionInfo;
  final AppUpdateService updateService;
  final VoidCallback onDismiss;

  const NotchUpdateBanner({
    super.key,
    required this.versionInfo,
    required this.updateService,
    required this.onDismiss,
  });

  @override
  State<NotchUpdateBanner> createState() => _NotchUpdateBannerState();
}

class _NotchUpdateBannerState extends State<NotchUpdateBanner> with WidgetsBindingObserver {
  bool _isMinimized = false;
  bool _isDownloading = false;
  double _progress = 0.0;
  String? _errorMessage;
  StreamSubscription<DownloadProgressEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isDownloading) {
      developer.log('🔄 [AppUpdate] App resumed from settings. Re-triggering installer...', name: 'AppUpdate');
      widget.updateService.downloadAndInstall(widget.versionInfo.downloadUrl).listen((_) {});
    }
  }

  void _startUpdate() {
    developer.log('⬇️ [AppUpdate] User tapped "Update"! Triggering APK download...', name: 'AppUpdate');
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
            _isMinimized = false;
            _errorMessage = 'Download failed: ${event.error}';
          });
        }
      },
      onError: (err) {
        setState(() {
          _isDownloading = false;
          _isMinimized = false;
          _errorMessage = 'Error downloading: $err';
        });
      },
    );
  }

  void _openFullDialog() {
    developer.log('📜 [AppUpdate] Opening full update release notes dialog...', name: 'AppUpdate');
    UpdateDialog.show(
      context,
      versionInfo: widget.versionInfo,
      decision: UpdateDecision.optional,
      updateService: widget.updateService,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: topPadding > 0 ? topPadding + 6 : 12,
      left: _isMinimized ? screenWidth * 0.14 : 14,
      right: _isMinimized ? screenWidth * 0.14 : 14,
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: _isMinimized ? 14 : 16,
            vertical: _isMinimized ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(_isMinimized ? 24 : 18),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                blurRadius: 16,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: _isMinimized ? _buildMinimizedPill(theme) : _buildExpandedBanner(theme, screenWidth),
        ),
      ),
    );
  }

  /// Minimized hardware notch pill (theme adaptive)
  Widget _buildMinimizedPill(ThemeData theme) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        developer.log('🔼 [AppUpdate] User tapped notch pill. Maximizing banner...', name: 'AppUpdate');
        setState(() => _isMinimized = false);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.system_update_rounded, color: theme.colorScheme.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            _isDownloading
                ? 'Downloading ${(_progress * 100).toInt()}%'
                : 'Update v${widget.versionInfo.latestVersion}',
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_isDownloading) ...[
            const SizedBox(width: 10),
            SizedBox(
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  color: theme.colorScheme.primary,
                  minHeight: 6,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Expanded banner (theme adaptive)
  Widget _buildExpandedBanner(ThemeData theme, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: Later Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                side: BorderSide(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                developer.log('🔽 [AppUpdate] User tapped "Later". Minimizing to notch pill.', name: 'AppUpdate');
                setState(() => _isMinimized = true);
              },
              child: Text(
                'Later',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12),
              ),
            ),

            // Center: Version Badge
            GestureDetector(
              onTap: _openFullDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'v${widget.versionInfo.latestVersion}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.info_outline_rounded, color: theme.colorScheme.primary, size: 16),
                  ],
                ),
              ),
            ),

            // Right Side: Update Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                backgroundColor: _isDownloading ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: _isDownloading ? null : _startUpdate,
              child: Text(
                _isDownloading ? 'Downloading...' : 'Update',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Description / Release notes preview
        GestureDetector(
          onTap: _openFullDialog,
          child: Text(
            widget.versionInfo.releaseNotes,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 12),
          ),
        ),

        // Real-Time Progress Bar inside Expanded Banner
        if (_isDownloading) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Downloading APK update...',
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                '${(_progress * 100).toInt()}%',
                style: TextStyle(color: theme.colorScheme.secondary, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              color: theme.colorScheme.primary,
              minHeight: 8,
            ),
          ),
        ],

        if (_errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            _errorMessage!,
            style: TextStyle(color: theme.colorScheme.error, fontSize: 11),
          ),
        ],
      ],
    );
  }
}
