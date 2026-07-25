import 'package:flutter/material.dart';

class AccuracyCircle extends StatefulWidget {
  final double radius;
  final bool isPulsing;

  const AccuracyCircle({
    super.key,
    required this.radius,
    this.isPulsing = true,
  });

  @override
  State<AccuracyCircle> createState() => _AccuracyCircleState();
}

class _AccuracyCircleState extends State<AccuracyCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.10,
      end: 0.22,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isPulsing) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AccuracyCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isPulsing != widget.isPulsing) {
      if (widget.isPulsing) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.animateTo(0.5, duration: const Duration(milliseconds: 300));
      }
    } else if (oldWidget.radius != widget.radius && widget.isPulsing) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = widget.isPulsing ? _scaleAnimation.value : 1.0;
        final opacity = widget.isPulsing ? _opacityAnimation.value : 0.15;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.radius * 2,
            height: widget.radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withValues(alpha: opacity),
            ),
          ),
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
