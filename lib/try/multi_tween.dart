import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ColorOn {
  final greyColor = Color(0xff29363D);
}

class LinePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  LinePainter(this.startPosition, this.endPosition);
  @override
  void paint(Canvas canvas, Size size) {
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

// class CurveLeft1 extends CustomPainter {
//   double curve;
//   double height;
//   CurveLeft1(this.curve, this.height);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final path = Path();
//     path.moveTo(100, 100);
//     path.quadraticBezierTo(curve, 100, 100, 140);
//     // path.moveTo(100, 140);
//     // path.quadraticBezierTo(100 + curve, 140, 100, 180 - height);

//     final Paint paint = Paint();
//     paint.color = Colors.grey;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 4.0;
//     paint.strokeCap = StrokeCap.round;

//     canvas.drawPath(path, paint);
//     // Add path points here based on your needs
//   }

//   @override
//   bool shouldRepaint(CurveLeft1 oldDelegate) {
//     return true;
//   }
// }

class CurveRight1 extends CustomPainter {
  Offset startPosition;
  double curve;
  double height;
  double height2;
  CurveRight1(this.startPosition, this.curve, this.height, this.height2);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final Paint paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;
    paint.strokeCap = StrokeCap.round;
    path.moveTo(startPosition.dx, startPosition.dy);
    path.quadraticBezierTo(startPosition.dx + curve, startPosition.dy + 20,
        startPosition.dx, startPosition.dy + 40);
    //path.quadraticBezierTo(100, 145, 100, 140);
    path.quadraticBezierTo(startPosition.dx + height, startPosition.dy + 60,
        startPosition.dx, startPosition.dy + 100 + height2);
    canvas.drawCircle(
        Offset(startPosition.dx, startPosition.dy + 100 + height2), 2, paint);

    // Path path = Path()
    //   ..moveTo(50, 100)
    //   ..quadraticBezierTo(75, 125, 50, 150) // first quadratic Bezier curve
    //   ..quadraticBezierTo(25, 175, 50, 200); // second quadratic Bezier curve
    // // ..lineTo(250, 150) // connect the two curves with a straight line
    // // ..lineTo(50, 150) // close the path
    // //..close();

    canvas.drawPath(path, paint);
    // Add path points here based on your needs
  }

  @override
  bool shouldRepaint(CurveRight1 oldDelegate) {
    return true;
  }
}

class MultiTween extends StatefulWidget {
  double mediaWidth;
  double mediaHeight;
  MultiTween({super.key, required this.mediaWidth, required this.mediaHeight});

  @override
  State<MultiTween> createState() => _CordStretchState();
}

class _CordStretchState extends State<MultiTween>
    with SingleTickerProviderStateMixin {
  double start1 = 1.0;
  // double start2 =
  late Offset startPosition;
  late Offset endPosition;
  late AnimationController animationController;
  late Animation animationLeft1;
  late Animation animationLeft2;

  double rightTween1Begin = 1.0;
  double rightTween1End = 50.0;

  double rightTween2Begin = 1.0;
  double rightTween2End = 20.0;

  late Animation animationRight1;
  late Animation animationRight2;

  late Animation animation;
  late Animation animation2;
  late Animation animation3;

  final angleStart = 0.0;
  double angleEnd = 50;

  late var sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 45.0, end: -45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -45.0, end: 25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: -25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 0), weight: 20),
  ]);

  var sizeAnimation2 = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -50.0, end: 50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 50.0, end: -25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: 0), weight: 20),
  ]);

  var sizeAnimation3 = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -20), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -20, end: 0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 20),
  ]);

  initializeTween() {}

  @override
  void initState() {
    startPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2);
    endPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 80);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animation = sizeAnimation.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animation2 = sizeAnimation2.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animation3 = sizeAnimation3.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    // sizeAnimation = Tween(begin: 100.0, end: 0.0)
    //     .chain(
    //       TweenSequence(<TweenSequenceItem<double>>[
    //         TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 20),
    //         TweenSequenceItem(
    //             tween: Tween(begin: 100.0, end: 50.0), weight: 20),
    //         TweenSequenceItem(tween: Tween(begin: 50.0, end: 75.0), weight: 20),
    //         TweenSequenceItem(tween: Tween(begin: 75.0, end: 0.0), weight: 20),
    //       ]),
    //     )
    //     .animate(CurvedAnimation(
    //         parent: animationController, curve: Interval(0.1, 1.0)));

    // sizeAnimation = TweenChain<double>()
    //   ..add(Tween<double>(begin: 0.0, end: 0.5), const Duration(seconds: 1))
    //   ..add(Tween<double>(begin: 0.5, end: 1.0).animate(parent),

    animationController.addListener(() {
      double currentDuration =
          double.parse(animationController.value.toStringAsFixed(1));

      print('size animation val is ${animation.value}');
      // print(currentDuration);
    });

    animationController.addStatusListener((status) {
      if (animationController.status == AnimationStatus.completed) {
      } else if (animationController.status == AnimationStatus.dismissed) {
        setState(() {
          // show = false;
          // showMain = true;
        });
      }
    });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          // show == true
          //     ? CustomPaint(
          //         painter: CurveLeft1(animationLeft1.value, animationLeft2.value),
          //         child: SizedBox(),
          //       )
          //     : IgnorePointer(),
          // show == true
          //     ? CustomPaint(
          //         painter: CurveRight1(animationRight1.value, animationRight2.value),
          //         child: SizedBox(),
          //       )
          //     : IgnorePointer(),
          Container(
            height: widget.mediaHeight,
            width: widget.mediaWidth,
            color: Colors.orange,
          ),
          CustomPaint(
            painter: CurveRight1(startPosition, animation.value,
                animation2.value, animation3.value),
            child: SizedBox(),
          ),

          Positioned(
              top: widget.mediaHeight / 2 - 30,
              left: widget.mediaWidth / 2 - 10,
              child: Container(
                height: 35,
                width: 25,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(20, 10),
                        topRight: Radius.elliptical(20, 10),
                        bottomLeft: Radius.elliptical(20, 10),
                        bottomRight: Radius.elliptical(20, 10))),
              )),
        ],
      ),
    ));
  }
}
