import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class LinePainter extends CustomPainter {
  Offset position;
  LinePainter(this.position);
  @override
  void paint(Canvas canvas, Size size) {
    print('size is $size');
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10;

    Offset startingPoint = Offset(50, 50);
    Offset endingPoint = position;

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class Change extends StatefulWidget {
  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> with SingleTickerProviderStateMixin {
  Offset position = Offset(50, 150);

  late Animation<Offset> _animation;
  late AnimationController _controller;

  // void _runAnimation(Offset pixelsPerSecond, Size size) {
  //   _animation = _controller.drive(
  //     AlignmentTween(
  //       begin: _dragAlignment,
  //       end: Alignment.center,
  //     ),
  //   );
  //   // Calculate the velocity relative to the unit interval, [0,1],
  //   // used by the animation controller.
  //   final unitsPerSecondX = pixelsPerSecond.dx / size.width;
  //   final unitsPerSecondY = pixelsPerSecond.dy / size.height;
  //   final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
  //   final unitVelocity = unitsPerSecond.distance;

  //   const spring = SpringDescription(
  //     mass: 20,
  //     stiffness: 0.1,
  //     damping: 1,
  //   );

  //   final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

  //   _controller.animateWith(simulation);
  // }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _controller.addListener(() {
      if (_controller.isCompleted) {}
      setState(() {
        position = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (details) {
          print('down');
        },
        onPanUpdate: (details) {
          setState(() {
            position =
                Offset(details.globalPosition.dx, details.globalPosition.dy);
          });
        },
        onPanEnd: (details) {
          print('this');
          _animation = Tween<Offset>(
            begin: position,
            end: Offset(50, 150),
          ).animate(
              CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

          _controller.forward();
        },
        child: CustomPaint(
          child: Container(),
          painter: LinePainter(position),
        ),
      ),
    );
  }
}
