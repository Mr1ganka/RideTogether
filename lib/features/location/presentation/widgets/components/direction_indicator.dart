import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants/location_marker_constants.dart';
import '../painters/direction_cone_painter.dart';

class DirectionIndicator extends StatefulWidget {
  final double heading;

  final bool isAnimating;

  const DirectionIndicator({
    super.key,
    required this.heading,
    this.isAnimating = true,
  });

  @override
  State<DirectionIndicator> createState() => _DirectionIndicatorState();
}

class _DirectionIndicatorState extends State<DirectionIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Animation<double>? _rotationAnimation;

  double _currentHeading = 0;

  @override
  void initState() {
    super.initState();

    _currentHeading = _normalize(widget.heading);

    _controller = AnimationController(
      vsync: this,

      duration: LocationMarkerConstants.headingAnimationDuration,
    );

    _rotationAnimation = AlwaysStoppedAnimation(
      _degreesToRadians(_currentHeading),
    );
  }

  @override
  void didUpdateWidget(DirectionIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.heading != widget.heading) {
      _animateHeading(widget.heading);
    }
  }

  void _animateHeading(double newHeading) {
    final target = _normalize(newHeading);

    if (!widget.isAnimating) {
      setState(() {
        _currentHeading = target;
      });

      return;
    }

    if (_controller.isAnimating && _rotationAnimation != null) {
      _currentHeading = _normalize(_rotationAnimation!.value * (180 / math.pi));
      _controller.stop();
    }

    final difference = _shortestDifference(_currentHeading, target);

    final end = _currentHeading + difference;

    _rotationAnimation =
        Tween<double>(
          begin: _degreesToRadians(_currentHeading),
          end: _degreesToRadians(end),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: LocationMarkerConstants.headingAnimationCurve,
          ),
        );

    _controller.forward(from: 0).then((_) {
      if (mounted) {
        _currentHeading = _normalize(end);
      }
    });
  }

  double _shortestDifference(double current, double target) {
    var diff = target - current;

    if (diff > 180) {
      diff -= 360;
    }

    if (diff < -180) {
      diff += 360;
    }

    return diff;
  }

  double _normalize(double value) {
    value %= 360;

    if (value < 0) {
      value += 360;
    }

    return value;
  }

  double _degreesToRadians(double value) {
    return value * (math.pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,

      builder: (context, child) {
        final rotation =
            _rotationAnimation?.value ?? _degreesToRadians(_currentHeading);

        return Transform.rotate(
          angle: rotation,
          child: const DirectionConePainterWidget(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
