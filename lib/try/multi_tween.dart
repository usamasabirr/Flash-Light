import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  double curve;
  double height;
  double height2;
  CurveRight1(this.curve, this.height, this.height2);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(100, 100);
    path.quadraticBezierTo(100 + curve, 100, 100, 140);
    path.moveTo(100, 140);
    path.quadraticBezierTo(100 + height, 140, 100, 180 + height2);

    final Paint paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4.0;
    paint.strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
    // Add path points here based on your needs
  }

  @override
  bool shouldRepaint(CurveRight1 oldDelegate) {
    return true;
  }
}

class MultiTween extends StatefulWidget {
  MultiTween({super.key});

  @override
  State<MultiTween> createState() => _CordStretchState();
}

class _CordStretchState extends State<MultiTween>
    with SingleTickerProviderStateMixin {
  final double x1 = 100.0;
  final double y1 = 100.0;
  final double x2 = 100.0;
  final double y2 = 180.0;
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
  var sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 100.0, end: -100.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -100.0, end: 50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 50.0, end: -50), weight: 20),
  ]);

  var sizeAnimation2 = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -100.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -100.0, end: 100.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 100.0, end: -50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -50.0, end: 50), weight: 20),
  ]);

  var sizeAnimation3 = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -20), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -20, end: 0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 20),
  ]);

  @override
  void initState() {
    startPosition = Offset(x1, y1);
    endPosition = Offset(x2, y2);
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

          CustomPaint(
            painter: CurveRight1(
                animation.value, animation2.value, animation3.value),
            child: SizedBox(),
          )

          // showMain == true
          //     ? GestureDetector(
          //         onPanDown: (details) {
          //           // setState(() {
          //           //   show = false;
          //           // });
          //           print('clicked');
          //         },
          //         onPanUpdate: (details) {
          //           print('clicked');
          //           setState(() {
          //             endPosition = Offset(
          //                 details.globalPosition.dx, details.globalPosition.dy);
          //           });
          //         },
          //         onPanEnd: (details) {
          //           setState(() {
          //             show = true;
          //             showMain = false;
          //             endPosition = Offset(100, 180);
          //           });
          //           animationController.forward();
          //         },
          //         child: CustomPaint(
          //           painter: LinePainter(startPosition, endPosition),
          //           child: Container(),
          //         ),
          //       )
          //     : IgnorePointer(),

          // ElevatedButton(
          //     onPressed: () {
          //       if (animationController.status == AnimationStatus.completed) {
          //         animationController.reverse();
          //       } else if (animationController.status ==
          //           AnimationStatus.dismissed) {
          //         animationController.forward();
          //       }
          //     },
          //     child: Text('Press me'))
        ],
      ),
    ));
  }
}
