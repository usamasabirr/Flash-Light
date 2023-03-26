import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class LinePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  LinePainter(this.startPosition, this.endPosition);
  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4;

    Offset startingPoint = startPosition;
    Offset endingPoint = endPosition;

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class CurvePainter1 extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  CurvePainter1(this.startPosition, this.endPosition);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();

    path.moveTo(startPosition.dx + 10, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx + 15, startPosition.dy + 25,
        startPosition.dx - 20, startPosition.dy + 30);
    path.quadraticBezierTo(startPosition.dx - 20, startPosition.dy + 38,
        startPosition.dx, startPosition.dy + 55);

    //path.lineTo(size.width, 0);
    //path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter1 oldDelegate) => true;
}

class Change extends StatefulWidget {
  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> with SingleTickerProviderStateMixin {
  final double x1 = 100.0;
  final double y1 = 250.0;
  final double x2 = 100.0;
  final double y2 = 350.0;
  late Offset startPosition;
  late Offset endPosition;

  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    startPosition = Offset(x1, y1);
    endPosition = Offset(x2, y2);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _controller.addListener(() {
      if (_controller.isCompleted) {}
      setState(() {
        endPosition = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GestureDetector(
          onPanDown: (details) {
            print('down');
          },
          onPanUpdate: (details) {
            setState(() {
              endPosition =
                  Offset(details.globalPosition.dx, details.globalPosition.dy);
            });
          },
          onPanEnd: (details) {
            print('this');
            _animation = Tween<Offset>(
              begin: endPosition,
              end: Offset(100, 350),
            ).animate(CurvedAnimation(
                parent: _controller, curve: Curves.elasticInOut));

            _controller.forward();
          },
          child: CustomPaint(
            child: Container(),
            painter: LinePainter(startPosition, endPosition),
          ),
        ),
        CustomPaint(
          child: Container(),
          painter: CurvePainter1(startPosition, endPosition),
        ),
      ]),
    );
  }
}
