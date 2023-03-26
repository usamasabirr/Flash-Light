import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  double x2, y2;
  LinePainter(this.x2, this.y2);
  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10;

    Offset startingPoint = Offset(50, 50);
    Offset endingPoint = Offset(x2, y2);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class Change extends StatefulWidget {
  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  double x2 = 50.0;
  double y2 = 150.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (details) {
          print('down');
        },
        onPanUpdate: (details) {
          setState(() {
            x2 = details.globalPosition.dx;
            y2 = details.globalPosition.dy;
          });

          print('x2 is $x2');
        },
        // onPanEnd: (details) {
        //   _runAnimation(details.velocity.pixelsPerSecond, size);
        // },
        child: CustomPaint(
          child: Container(),
          painter: LinePainter(x2, y2),
        ),
      ),
    );
  }
}
