import 'package:flutter/material.dart';
import 'dart:math' as math;

class BulbPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    Path path = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    double startAngle = -math.pi / 2; // 270 degrees
    double sweepAngle = math.pi * 3 / 2; // 270 degrees

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BulbWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      child: CustomPaint(
        painter: BulbPainter(),
      ),
    );
  }
}
