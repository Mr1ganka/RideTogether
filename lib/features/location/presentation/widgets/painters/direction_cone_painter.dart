import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_colors.dart';

class DirectionConePainterWidget extends StatelessWidget {
  const DirectionConePainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(
        AppColors.directionConeSize,
        AppColors.directionConeSize,
      ),
      painter: const DirectionConePainter(),
    );
  }
}

class DirectionConePainter extends CustomPainter {
  final Color color;

  const DirectionConePainter({this.color = AppColors.directionConeBeam});

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
    const endAngleRad = startAngleRad + sweepAngleRad;

    final circleRect = Rect.fromCircle(center: center, radius: radius);

    final beamPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        circleRect,
        startAngleRad,
        sweepAngleRad,
        false,
      )
      ..lineTo(center.dx, center.dy)
      ..close();

    // 1. Soft blurred fill towards the middle
    final fillPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          color.withValues(alpha: 0.75),
          color.withValues(alpha: 0.35),
          color.withValues(alpha: 0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(circleRect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.5)
      ..isAntiAlias = true;

    canvas.drawPath(beamPath, fillPaint);

    // 2. Prominent side edges
    final leftRayEnd = Offset(
      center.dx + radius * math.cos(startAngleRad),
      center.dy + radius * math.sin(startAngleRad),
    );
    final rightRayEnd = Offset(
      center.dx + radius * math.cos(endAngleRad),
      center.dy + radius * math.sin(endAngleRad),
    );

    final edgePath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(leftRayEnd.dx, leftRayEnd.dy)
      ..moveTo(center.dx, center.dy)
      ..lineTo(rightRayEnd.dx, rightRayEnd.dy);

    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        begin: Alignment.center,
        end: Alignment.topCenter,
        colors: [
          color.withValues(alpha: 0.95),
          color.withValues(alpha: 0.45),
        ],
      ).createShader(circleRect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.8)
      ..isAntiAlias = true;

    canvas.drawPath(edgePath, edgePaint);
  }

  @override
  bool shouldRepaint(covariant DirectionConePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
