
import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_colors.dart';

class DirectionConePainterWidget extends StatelessWidget {
  const DirectionConePainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(AppColors.directionConeSize, AppColors.directionConeSize),
      painter: DirectionConePainter(),
    );
  }
}

class DirectionConePainter extends CustomPainter {
  static const _alphaStrong = AppColors.directionConeAlphaStrong;
  static const _alphaMid = AppColors.directionConeAlphaMid;
  static const _alphaFade = AppColors.directionConeAlphaFade;
  static const _blur = AppColors.directionConeBlur;
  static const _color = AppColors.directionConeBeam;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final beamPath = Path();

    beamPath.moveTo(center.dx - size.width * 0.1, center.dy);

    beamPath.quadraticBezierTo(
      center.dx - size.width * 0.25,
      center.dy - size.height * 0.275,
      center.dx - size.width * 0.225,
      center.dy - size.height * 0.6,
    );

    beamPath.quadraticBezierTo(
      center.dx,
      center.dy - size.height * 0.75,
      center.dx + size.width * 0.225,
      center.dy - size.height * 0.6,
    );

    beamPath.quadraticBezierTo(
      center.dx + size.width * 0.25,
      center.dy - size.height * 0.275,
      center.dx + size.width * 0.1,
      center.dy,
    );

    beamPath.close();

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          _color.withValues(alpha: _alphaStrong),
          _color.withValues(alpha: _alphaMid),
          _color.withValues(alpha: _alphaFade),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Offset.zero & size)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _blur)
      ..isAntiAlias = true;

    canvas.drawPath(beamPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
