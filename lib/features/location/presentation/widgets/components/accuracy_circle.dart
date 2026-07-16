import 'package:flutter/material.dart';

class AccuracyCircle extends StatefulWidget {
  final double radius;

  const AccuracyCircle({super.key, required this.radius});

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

    // Continuous breathing effect.
    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(AccuracyCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart only if the radius changes.
    if (oldWidget.radius != widget.radius) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,

      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,

          child: Container(
            width: widget.radius * 2,

            height: widget.radius * 2,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: Colors.blue.withValues(alpha: _opacityAnimation.value),
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
