
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_colors.dart';

class DirectionConePainterWidget extends StatelessWidget {
  const DirectionConePainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(AppColors.directionConeSize, AppColors.directionConeSize),
      painter: const DirectionConePainter(),
    );
  }
}

class DirectionConePainter extends CustomPainter {
  final Color color;

  const DirectionConePainter({
    this.color = AppColors.directionConeBeam,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 36.0;

    // Google Maps directional beam wedge angle: 54 degrees
    const sweepAngleDeg = 54.0;
    const sweepAngleRad = sweepAngleDeg * (math.pi / 180.0);

    // North / Up is -90 degrees (-pi/2)
    const startAngleDeg = -90.0 - (sweepAngleDeg / 2.0);
    const startAngleRad = startAngleDeg * (math.pi / 180.0);

    final beamPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        startAngleRad,
        sweepAngleRad,
        false,
      )
      ..lineTo(center.dx, center.dy)
      ..close();

    final circleRect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          color.withValues(alpha: 0.85),
          color.withValues(alpha: 0.50),
          color.withValues(alpha: 0.15),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(circleRect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5)
      ..isAntiAlias = true;

    canvas.drawPath(beamPath, paint);
  }

  @override
  bool shouldRepaint(covariant DirectionConePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

