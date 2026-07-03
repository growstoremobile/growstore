import 'package:flutter/material.dart';

class RegisterBackgroundPainterWidget extends CustomPainter {
  const RegisterBackgroundPainterWidget({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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
  bool shouldRepaint(covariant RegisterBackgroundPainterWidget oldDelegate) {
    return oldDelegate.color != color;
  }
}
