import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ColorOn {
  final greyColor = Color(0xff29363D);
}

class CordPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  CordPainter(this.startPosition, this.endPosition);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4;

    Offset startingPoint = startPosition;
    Offset endingPoint = endPosition;

    canvas.drawLine(startingPoint, endingPoint, paint);
    canvas.drawCircle(Offset(endPosition.dx, endPosition.dy), 4, paint);
  }

  @override
  bool shouldRepaint(CordPainter oldDelegate) => true;
}

class AnimatedCordPainter extends CustomPainter {
  Offset startPosition;
  double curve;
  double height;
  double height2;
  AnimatedCordPainter(
      this.startPosition, this.curve, this.height, this.height2);
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
    path.quadraticBezierTo(startPosition.dx + height, startPosition.dy + 60,
        startPosition.dx, startPosition.dy + 100 + height2);
    canvas.drawCircle(
        Offset(startPosition.dx, startPosition.dy + 100 + height2), 2, paint);

    canvas.drawPath(path, paint);
    // Add path points here based on your needs
  }

  @override
  bool shouldRepaint(AnimatedCordPainter oldDelegate) {
    return true;
  }
}

class Development extends StatefulWidget {
  double mediaWidth;
  double mediaHeight;
  Development({super.key, required this.mediaWidth, required this.mediaHeight});

  @override
  State<Development> createState() => _CordStretchState();
}

class _CordStretchState extends State<Development>
    with SingleTickerProviderStateMixin {
  late Offset startPosition;
  late Offset endPosition;

  late AnimationController animationController;
  late Animation upperCurveAnimation;
  late Animation lowerCurveAnimation;
  late Animation lowerCurveCompressAnimation;

  bool showAnimation = false;
  bool showCord = true;

  late var upperCurveTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 45.0, end: -45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -45.0, end: 25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: -25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 0), weight: 20),
  ]);

  var lowerCurveTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -50.0, end: 50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 50.0, end: -25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: 0), weight: 20),
  ]);

  var lowerCurveCompressTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -20), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -20, end: 0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 20),
  ]);

  initializeTween() {}

  @override
  void initState() {
    startPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2);
    endPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    upperCurveAnimation = upperCurveTween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    lowerCurveAnimation = lowerCurveTween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    lowerCurveCompressAnimation =
        lowerCurveCompressTween.animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationController.addListener(() {
      double currentDuration =
          double.parse(animationController.value.toStringAsFixed(1));

      print('size upperCurveAnimation val is ${upperCurveAnimation.value}');
      // print(currentDuration);
    });

    animationController.addStatusListener((status) {
      if (animationController.status == AnimationStatus.completed) {
        setState(() {
          showCord = true;
          showAnimation = false;
        });
        animationController.reset();
      } else if (animationController.status == AnimationStatus.dismissed) {}
    });
    //animationController.forward();
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
          //         painter: AnimatedCordPainter(animationRight1.value, animationRight2.value),
          //         child: SizedBox(),
          //       )
          //     : IgnorePointer(),
          Container(
            height: widget.mediaHeight,
            width: widget.mediaWidth,
            color: Colors.orange,
          ),
          showAnimation == true
              ? CustomPaint(
                  painter: AnimatedCordPainter(
                      startPosition,
                      upperCurveAnimation.value,
                      lowerCurveAnimation.value,
                      lowerCurveCompressAnimation.value),
                  child: SizedBox(),
                )
              : IgnorePointer(),

          showCord == true
              ? GestureDetector(
                  onPanDown: (details) {},
                  onPanUpdate: (details) {
                    setState(() {
                      endPosition = Offset(
                          details.globalPosition.dx, details.globalPosition.dy);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      endPosition = Offset(
                          widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);
                      showAnimation = true;
                      showCord = false;
                    });
                    animationController.forward();
                  },
                  child: CustomPaint(
                    painter: CordPainter(startPosition, endPosition),
                    child: Container(),
                  ),
                )
              : IgnorePointer(),

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
