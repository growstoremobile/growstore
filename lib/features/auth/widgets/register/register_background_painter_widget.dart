import 'package:flutter/material.dart';
import 'package:growstore/shared/colors/colors.dart';

/// Custom painter para desenhar o background pontilhado (hero-pattern)
class RegisterBackgroundPainterWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.growthGreen.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    const spacing = 24.0;
    const radius = 1.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
