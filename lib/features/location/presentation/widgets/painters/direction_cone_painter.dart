import 'dart:ui';

import 'package:flutter/material.dart';

class DirectionConePainterWidget extends StatelessWidget {
  const DirectionConePainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: DirectionConePainter(),
    );
  }
}

class DirectionConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final beamPath = Path();

    /*
      The beam starts underneath the dot.

      It is intentionally NOT a triangle.
      The shape is only a mask for the gradient.

      The blur does the visual work.
    */

    beamPath.moveTo(center.dx - 8, center.dy);

    beamPath.quadraticBezierTo(
      center.dx - 20,
      center.dy - 22,
      center.dx - 18,
      center.dy - 48,
    );

    beamPath.quadraticBezierTo(
      center.dx,
      center.dy - 60,
      center.dx + 18,
      center.dy - 48,
    );

    beamPath.quadraticBezierTo(
      center.dx + 20,
      center.dy - 22,
      center.dx + 8,
      center.dy,
    );

    beamPath.close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomCenter,

        end: Alignment.topCenter,

        colors: [
          Color.fromRGBO(66, 133, 244, 0.45),

          Color.fromRGBO(66, 133, 244, 0.18),

          Color.fromRGBO(66, 133, 244, 0.0),
        ],

        stops: [0.0, 0.45, 1.0],
      ).createShader(Offset.zero & size)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..isAntiAlias = true;

    canvas.drawPath(beamPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
