import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  final BuildContext context;

  ShapePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Theme.of(context).colorScheme.primary;

    // draw path
    Path path = Path();
    path.moveTo(0, 0); // Start at top-left corner
    path.lineTo(0, size.height); // Straight line down
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.3, size.width, size.height); // Curve
    path.lineTo(size.width, 0); // Straight line to top-right corner
    path.close(); // Close the path to form a continuous shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
