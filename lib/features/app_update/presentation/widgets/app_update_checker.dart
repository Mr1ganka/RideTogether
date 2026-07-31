import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/services/app_update_service.dart';
import '../../domain/services/update_decision.dart';
import '../providers/app_update_providers.dart';
import 'notch_update_banner.dart';
import 'update_dialog.dart';

/// A wrapper widget that triggers version update checks on launch
/// and displays either the NotchUpdateBanner (for notched phones) or standard UpdateDialog.
class AppUpdateChecker extends ConsumerStatefulWidget {
  final Widget child;

  const AppUpdateChecker({super.key, required this.child});

  @override
  ConsumerState<AppUpdateChecker> createState() => _AppUpdateCheckerState();
}

class _AppUpdateCheckerState extends ConsumerState<AppUpdateChecker> {
  bool _bannerShown = false;
  OverlayEntry? _notchOverlayEntry;
  StreamSubscription<DownloadProgressEvent>? _silentSubscription;

  @override
  void initState() {
    super.initState();
    // Check state immediately if provider already completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final asyncState = ref.read(checkForUpdatesProvider);
        asyncState.whenData(_handleUpdateState);
      }
    });
  }

  @override
  void dispose() {
    _silentSubscription?.cancel();
    super.dispose();
  }

  void _removeNotchBanner() {
    _notchOverlayEntry?.remove();
    _notchOverlayEntry = null;
  }

  void _handleUpdateState(AppUpdateState state) {
    if (_bannerShown || state.info == null || state.decision == UpdateDecision.none) {
      return;
    }

    final info = state.info!;
    final updateService = ref.read(appUpdateServiceProvider);

    if (state.decision == UpdateDecision.mandatory) {
      _bannerShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          UpdateDialog.show(
            context,
            versionInfo: info,
            decision: state.decision,
            updateService: updateService,
          );
        }
      });
    } else if (state.decision == UpdateDecision.optional) {
      _bannerShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _notchOverlayEntry != null) return;

        final topInset = MediaQuery.of(context).padding.top;
        final hasNotch = topInset > 20;

        if (hasNotch) {
          // Display notch pill banner stably anchored at top notch area
          _notchOverlayEntry = OverlayEntry(
            builder: (ctx) => NotchUpdateBanner(
              versionInfo: info,
              updateService: updateService,
              onDismiss: _removeNotchBanner,
            ),
          );
          Overlay.of(context).insert(_notchOverlayEntry!);
        } else {
          // Fall back to standard centered dialog
          UpdateDialog.show(
            context,
            versionInfo: info,
            decision: state.decision,
            updateService: updateService,
          );
        }
      });
    } else if (state.decision == UpdateDecision.silent) {
      _startSilentDownload(info.downloadUrl);
    }
  }

  void _startSilentDownload(String downloadUrl) {
    final updateService = ref.read(appUpdateServiceProvider);
    _silentSubscription = updateService.downloadAndInstall(downloadUrl).listen(
      (event) {
        if (event.status == DownloadStatus.installing && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.surfaceVariant,
              content: Text(
                'Update downloaded and ready to install!',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              duration: Duration(seconds: 10),
            ),
          );
        }
      },
      onError: (_) {
        // Silent download failed
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AppUpdateState>>(
      checkForUpdatesProvider,
      (previous, next) {
        next.whenData(_handleUpdateState);
      },
    );

    return widget.child;
  }
}
