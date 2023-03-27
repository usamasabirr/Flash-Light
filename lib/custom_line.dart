import 'package:animated_path/animated_path.dart';
import 'package:drawing_animation/drawing_animation.dart';
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
  Path path;

  CurvePainter1(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();

    //path.lineTo(size.width, 0);
    //path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter1 oldDelegate) => true;
}

class CurvePainter2 extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  CurvePainter2(this.startPosition, this.endPosition);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();

    path.moveTo(startPosition.dx - 10, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx - 15, startPosition.dy + 25,
        startPosition.dx + 20, startPosition.dy + 60);
    path.quadraticBezierTo(startPosition.dx + 20, startPosition.dy + 60,
        startPosition.dx, startPosition.dy + 80);

    //path.lineTo(size.width, 0);
    //path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter2 oldDelegate) => true;
}

class CurvePainter3 extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  CurvePainter3(this.startPosition, this.endPosition);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();

    path.moveTo(startPosition.dx + 7, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx + 15, startPosition.dy + 45,
        startPosition.dx - 15, startPosition.dy + 40);
    path.quadraticBezierTo(startPosition.dx - 20, startPosition.dy + 48,
        startPosition.dx, startPosition.dy + 95);

    //path.lineTo(size.width, 0);
    //path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter3 oldDelegate) => true;
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
  Path path = Path();

  List<Path> curvedPaths = [];

  List<bool> showCurve = [false, false, false];
  bool showMain = true;

  late Animation<Offset> _animation;
  late Animation<Path> _curve1Animation;
  late AnimationController _controller;
  bool run = true;

  Path calculatePath1() {
    var path = Path();

    path.moveTo(startPosition.dx + 7, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx + 15, startPosition.dy + 45,
        startPosition.dx - 15, startPosition.dy + 40);
    path.quadraticBezierTo(startPosition.dx - 20, startPosition.dy + 48,
        startPosition.dx, startPosition.dy + 95);

    return path;
  }

  Path calculatePath2() {
    var paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;

    var path = Path();

    path.moveTo(startPosition.dx - 10, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx - 15, startPosition.dy + 25,
        startPosition.dx + 20, startPosition.dy + 60);
    path.quadraticBezierTo(startPosition.dx + 20, startPosition.dy + 60,
        startPosition.dx, startPosition.dy + 80);
    return path;
  }

  hide() async {
    await Future.delayed(Duration(milliseconds: 10));
    setState(() {
      showCurve[0] = false;
      showCurve[1] = true;
    });
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      showCurve[1] = false;
      showCurve[2] = true;
    });
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      showCurve[2] = false;
      showMain = true;
    });
  }

  @override
  void initState() {
    super.initState();

    startPosition = Offset(x1, y1);
    endPosition = Offset(x2, y2);
    curvedPaths.add(calculatePath1());
    curvedPaths.add(calculatePath2());
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {
          showMain = false;
          showCurve[0] = true;
          hide();
        });

        _controller.forward();
      }
      setState(() {
        endPosition = _animation.value;
        // path = _curve1Animation.value;
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
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(left: mediaWidth / 2, top: mediaHeight / 2),
        child: Stack(children: [
          showMain == true
              ? GestureDetector(
                  onPanDown: (details) {
                    print('down');
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      endPosition = Offset(
                          details.globalPosition.dx, details.globalPosition.dy);
                    });
                  },
                  onPanEnd: (details) {
                    print('this');
                    _animation = Tween<Offset>(
                      begin: endPosition,
                      end: Offset(100, 350),
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0, 0.5, curve: Curves.linear),
                    ));
                    // Path temp = Path();
                    // temp.moveTo(startPosition.dx + 7, startPosition.dy);
                    // _curve1Animation =
                    //     Tween<Path>(begin: temp, end: curvedPaths[0]).animate(
                    //         CurvedAnimation(
                    //             parent: _controller, curve: Interval(0.5, 1)));

                    _controller.forward();
                  },
                  child: CustomPaint(
                    child: Container(),
                    painter: LinePainter(startPosition, endPosition),
                  ),
                )
              : IgnorePointer(),
          AnimatedPath(
            animation: _controller.view,
            path: Path()
              ..moveTo(100, 100)
              ..relativeLineTo(400, 0)
              ..relativeLineTo(0, 400)
              ..relativeLineTo(-400, 0)
              ..relativeLineTo(0, -400),
            paint: Paint(),
            start: Tween(begin: 0.0, end: 0.7),
            end: Tween(begin: 0.0, end: 1.0),
            offset: Tween(begin: 0.0, end: 0.3),
          )
          // AnimatedDrawing.paths(this.curvedPaths,
          //     width: 20,
          //     height: 100,
          //     run: run,

          //     animationOrder: PathOrders.original,
          //     duration: new Duration(milliseconds: 600),
          //     lineAnimation: LineAnimation.oneByOne,
          //     animationCurve: Curves.linear,
          //     onFinish: () => setState(() {
          //           run = false;
          //         })),
          // showCurve[0] == true
          //     ? CustomPaint(
          //         child: Container(),
          //         painter: CurvePainter1(path),
          //       )
          //     : IgnorePointer(),
          // showCurve[1] == true
          //     ? CustomPaint(
          //         child: Container(),
          //         painter: CurvePainter2(startPosition, endPosition),
          //       )
          //     : IgnorePointer(),
          // showCurve[2] == true
          //     ? CustomPaint(
          //         child: Container(),
          //         painter: CurvePainter3(startPosition, endPosition),
          //       )
          //     : IgnorePointer(),
        ]),
      ),
    );
  }
}
