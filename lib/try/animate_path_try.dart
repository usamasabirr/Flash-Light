import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyPathAnimation extends StatefulWidget {
  @override
  _MyPathAnimationState createState() => _MyPathAnimationState();
}

class _MyPathAnimationState extends State<MyPathAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final double x1 = 100.0;
  final double y1 = 250.0;
  final double x2 = 100.0;
  final double y2 = 350.0;
  late Offset startPosition;
  late Offset endPosition;

  @override
  void initState() {
    super.initState();
    startPosition = Offset(x1, y1);
    endPosition = Offset(x2, y2);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    //_animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: CustomPaint(
              painter: MyPainter(_animation.value, startPosition, endPosition),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _animationController.forward();
              },
              child: Text('child'))
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double _animationValue;
  Offset startPosition;
  Offset endPosition;

  MyPainter(this._animationValue, this.startPosition, this.endPosition);

  Path extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = new Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        // There might be a more efficient way of extracting an entire path
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    // ComputeMetrics can only be iterated once!
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path _createAnyPath(startPosition, endPosition) {
    return Path()
      ..moveTo(startPosition.dx + 10, startPosition.dy)
      ..quadraticBezierTo(startPosition.dx + 15, startPosition.dy + 45,
          startPosition.dx - 15, startPosition.dy + 40)
      ..quadraticBezierTo(startPosition.dx - 20, startPosition.dy + 48,
          startPosition.dx, startPosition.dy + 95);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = createAnimatedPath(
        _createAnyPath(startPosition, endPosition), _animationValue);

    final Paint paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    canvas.drawPath(path, paint);
    // Add path points here based on your needs
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate._animationValue != _animationValue;
  }
}
