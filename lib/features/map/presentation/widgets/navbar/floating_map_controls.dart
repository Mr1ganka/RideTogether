import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:ride_together/core/theme/app_durations.dart';
import 'package:ride_together/core/theme/app_spacing.dart';

import '../../../domain/entities/map_mode.dart';
import '../../providers/map_mode_provider.dart';
import '../../utils/map_animation_utils.dart';
import '../../../../auth/presentation/providers/auth_repository_provider.dart';
import '../../../../location/presentation/providers/current_posisiton_provider.dart';

import 'recenter_button.dart';
import 'zoom_controls.dart';
import 'bottom_nav_bar.dart';
import 'nav_handle.dart';
import '../../../../ride/presentation/widgets/join_ride_sheet.dart';

class FloatingMapControls extends ConsumerStatefulWidget {
  const FloatingMapControls({super.key, required this.mapController});

  final MapController mapController;

  @override
  ConsumerState<FloatingMapControls> createState() =>
      _FloatingMapControlsState();
}

class _FloatingMapControlsState extends ConsumerState<FloatingMapControls>
    with TickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  bool _barVisible = true;
  Timer? _autoHideTimer;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1.15)).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
        );

    _resetAutoHideTimer();
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    _slideController.dispose();
    super.dispose();
  }

  void _toggleBar() {
    if (_slideController.isAnimating) return;

    if (_barVisible) {
      _hideBar();
    } else {
      _showBar();
    }
  }

  void _showBar() {
    if (!_barVisible) {
      _slideController.reverse();

      setState(() {
        _barVisible = true;
      });
    }

    _resetAutoHideTimer();
  }

  void _hideBar() {
    if (_barVisible) {
      _slideController.forward();

      setState(() {
        _barVisible = false;
      });
    }

    _autoHideTimer?.cancel();
  }

  void _resetAutoHideTimer() {
    _autoHideTimer?.cancel();

    _autoHideTimer = Timer(AppDurations.autoHideNav, () {
      if (mounted) {
        _hideBar();
      }
    });
  }

  void _onRecenter() {
    final position = ref.read(currentPositionProvider).value;

    if (position != null) {
      animatedMapMove(
        mapController: widget.mapController,
        vsync: this,
        destLocation: LatLng(position.latitude, position.longitude),
        destZoom: widget.mapController.camera.zoom.clamp(14.0, 18.0),
        duration: const Duration(milliseconds: 650),
      );
    }

    _resetAutoHideTimer();
  }

  void _onZoomIn() {
    final camera = widget.mapController.camera;
    animatedMapMove(
      mapController: widget.mapController,
      vsync: this,
      destLocation: camera.center,
      destZoom: (camera.zoom + 1.0).clamp(1.0, 20.0),
      duration: const Duration(milliseconds: 300),
    );
    _resetAutoHideTimer();
  }

  void _onZoomOut() {
    final camera = widget.mapController.camera;
    animatedMapMove(
      mapController: widget.mapController,
      vsync: this,
      destLocation: camera.center,
      destZoom: (camera.zoom - 1.0).clamp(1.0, 20.0),
      duration: const Duration(milliseconds: 300),
    );
    _resetAutoHideTimer();
  }

  void _onJoinRide() {
    _resetAutoHideTimer();
    JoinRideSheet.show(context);
  }

  Future<void> _onLogout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
  }

  double _navBarHeight(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return screenW * 0.17;
  }

  double _handleHeight(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return screenW * 0.08;
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(mapModeProvider);

    if (mode == MapMode.navigation) {
      return const SizedBox.shrink();
    }

    final navBarHeight = _navBarHeight(context);
    final handleHeight = _handleHeight(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: AppSpacing.mapPadding,
          bottom: AppSpacing.bottomNavAir + navBarHeight + handleHeight + 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ZoomControls(
                onZoomIn: _onZoomIn,
                onZoomOut: _onZoomOut,
              ),
              const SizedBox(height: 12),
              RecenterButton(onTap: _onRecenter),
            ],
          ),
        ),

        // Navbar
        Positioned(
          left: AppSpacing.mapPadding,
          right: AppSpacing.mapPadding,
          bottom: AppSpacing.mapPadding + AppSpacing.bottomNavAir + 12,
          child: SlideTransition(
            position: _slideAnimation,
            child: SizedBox(
              height: navBarHeight + handleHeight * 0.45,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BottomNavBar(
                      onProfileTap: _resetAutoHideTimer,
                      onMyRidesTap: _resetAutoHideTimer,
                      onJoinRideTap: _onJoinRide,
                      onSettingsTap: _resetAutoHideTimer,
                      onLogoutTap: _onLogout,
                    ),
                  ),

                  Positioned(
                    top: -(handleHeight * 0.55),
                    child: NavHandle(
                      barVisible: _barVisible,
                      onTap: _toggleBar,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
