import 'package:audioplayers/audioplayers.dart';
//import 'package:flashlight/flashlight.dart';
//import 'package:flashlight/flashlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:torch_light/torch_light.dart';

class ColorOff {
  static final extraLightGreyColor = Color(0xffD9D9D9);
  static final greyColor = Color(0xff29363D);
  static final mediumGreyColor = Color(0xff666666);
  static final lightGreyColor = Color(0xff999999);
  static final green = Color(0xff364950);
  static final ovalColor = Color(0xff6C7474);
}

class ColorOn {
  static final yellowColor = Color(0xffF0D8A8);
  static final blackColor = Colors.black;
  static final lineColor = Color(0xffE2E7A6);
  static final bulbColor = Color(0xffE2E7A6);
  static final ovalColor = Color(0xfff0d8a8);
}

class CordPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  CordPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..strokeWidth = 4;

    canvas.drawLine(startPosition, endPosition, paint);
    canvas.drawCircle(Offset(endPosition.dx, endPosition.dy), 4, paint);
  }

  @override
  bool shouldRepaint(CordPainter oldDelegate) => true;
}

class BulbBottomCurvePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbBottomCurvePainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Paint paint2 = Paint()
      ..color =
          isOff == true ? ColorOff.mediumGreyColor : ColorOff.lightGreyColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path = Path();
    path.moveTo(startPosition.dx - 15, startPosition.dy - 10);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy + 15,
        startPosition.dx + 15, startPosition.dy - 10);
    path.lineTo(startPosition.dx + 15, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 55,
        startPosition.dx - 15, startPosition.dy - 40);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbBottomCurvePainter oldDelegate) => true;
}

class LinePainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  LinePainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true
          ? ColorOff.mediumGreyColor
          : Color.fromARGB(255, 198, 240, 30)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    Paint paint2 = Paint()
      ..color = ColorOff.mediumGreyColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path = Path();
    path.moveTo(startPosition.dx - 5, startPosition.dy - 40);
    path.lineTo(startPosition.dx - 10, startPosition.dy - 55);

    canvas.drawPath(path, paint);

    path.moveTo(startPosition.dx + 5, startPosition.dy - 40);
    path.lineTo(startPosition.dx + 10, startPosition.dy - 55);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class BulbOvalPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbOvalPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    Paint paint2 = Paint()
      ..color = isOff == true ? ColorOff.ovalColor : ColorOn.ovalColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Path path = Path();
    path.moveTo(startPosition.dx + 15, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 55,
        startPosition.dx - 15, startPosition.dy - 40);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 30,
        startPosition.dx + 15, startPosition.dy - 40);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbOvalPainter oldDelegate) => true;
}

class BulbPainter extends CustomPainter {
  Offset startPosition;
  Offset endPosition;
  bool isOff;
  BulbPainter(this.startPosition, this.endPosition, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isOff == true ? ColorOff.lightGreyColor : ColorOn.blackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Paint paint2 = Paint()
      ..color = isOff == true ? ColorOff.green : ColorOn.bulbColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var path = Path();
    path.addArc(
        Rect.fromCenter(
            center: Offset(startPosition.dx, startPosition.dy - 80),
            width: 70,
            height: 70),
        2.35619,
        4.77);
    path.lineTo(startPosition.dx + 10, startPosition.dy - 20);
    path.quadraticBezierTo(startPosition.dx, startPosition.dy - 12,
        startPosition.dx - 10, startPosition.dy - 20);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint2);
  }

  @override
  bool shouldRepaint(BulbPainter oldDelegate) => true;
}

class AnimatedCordPainter extends CustomPainter {
  Offset startPosition;
  double curve;
  double height;
  double height2;
  bool isOff;
  AnimatedCordPainter(
      this.startPosition, this.curve, this.height, this.height2, this.isOff);
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final Paint paint = Paint();
    paint.color = isOff == true ? ColorOff.lightGreyColor : Colors.black;
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
  bool flag = false;
  Development({super.key, required this.mediaWidth, required this.mediaHeight});

  @override
  State<Development> createState() => _CordStretchState();
}

class _CordStretchState extends State<Development>
    with SingleTickerProviderStateMixin {
  late Offset startPosition;
  late Offset endPosition;

  bool flag = false;

  //to control the animation
  late AnimationController animationController;

  //store different type of animations
  late Animation cordAnimation;
  late Animation upperCurveAnimation;
  late Animation lowerCurveAnimation;
  late Animation lowerCurveCompressAnimation;

  //when true start showing the animation
  bool showAnimation = false;

  bool showCord = true;

  bool isOff = true;

  final player = AudioPlayer();

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

  playMusic() async {
    await player.play(AssetSource('audio/switch.mp3'));
  }

  @override
  void initState() {
    //get the start and end position for the cord
    startPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2);
    endPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    //create animaiton for the upper curve
    upperCurveAnimation = upperCurveTween.animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //create animation for the lower curve
    lowerCurveAnimation = lowerCurveTween.animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //create animation for compress cord effect
    lowerCurveCompressAnimation = lowerCurveCompressTween.animate(
        CurvedAnimation(
            parent: animationController, curve: Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //listen to any changes
    animationController.addListener(() {
      print('value is ${animationController.value}');
      double currentDuration =
          double.parse(animationController.value.toStringAsFixed(2));

      if (currentDuration == 0.2) {
        setState(() {
          // isOff = !isOff;
          showAnimation = true;
          showCord = false;
        });
      }
    });

    //listen to the status of the animation i.e completed, stopped etc
    animationController.addStatusListener((status) {
      if (animationController.status == AnimationStatus.completed) {
        print('Animation Completed');
        animationController.reset();
        setState(() {
          //isOff = !isOff;
          //isOff = !isOff;
          showCord = true;
          showAnimation = false;
          endPosition =
              Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);
        });
      } else if (animationController.status == AnimationStatus.dismissed) {}
    });
    //animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: widget.mediaHeight,
        width: widget.mediaWidth,
        child: Stack(
          children: [
            //first child of stack will be a full screen size container
            //stack will take the length of the first child
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: isOff == true ? ColorOff.greyColor : ColorOn.yellowColor,
            ),
            //conditionalRendering: if show animation is true show the animated cord
            //other wise show nothing
            showAnimation == true
                ? CustomPaint(
                    painter: AnimatedCordPainter(
                        startPosition,
                        upperCurveAnimation.value,
                        lowerCurveAnimation.value,
                        lowerCurveCompressAnimation.value,
                        isOff),
                    child: SizedBox(),
                  )
                : IgnorePointer(),
            //bulb root
            CustomPaint(
                child: Container(),
                painter: BulbPainter(startPosition, endPosition, isOff)),

            //bulb bottom cord
            CustomPaint(
                child: Container(),
                painter:
                    BulbBottomCurvePainter(startPosition, endPosition, isOff)),

            //bulb bottom cord
            CustomPaint(
                child: Container(),
                painter: BulbOvalPainter(startPosition, endPosition, isOff)),

            //oval painter
            CustomPaint(
                child: Container(),
                painter: LinePainter(startPosition, endPosition, isOff)),

            //Conditional Rendering: if true show the original cord
            showCord == true
                ? GestureDetector(
                    onPanDown: (details) {},
                    onPanUpdate: (details) {
                      //when ever you drag your finger change the
                      //endposition with new coordinates and update
                      //the state. you will be able to achieve the
                      //drag effect
                      setState(() {
                        endPosition = Offset(details.globalPosition.dx,
                            details.globalPosition.dy);
                      });
                    },
                    //when you lift you finger up show the animation
                    onPanEnd: (details) async {
                      ////Uncomment: the below lines to turn the flash light on and off too

                      // if (flag == false) {
                      //   Flashlight.lightOn();
                      // } else {
                      //   Flashlight.lightOff();
                      // }
                      flag = !flag;
                      //function to play the music
                      playMusic();
                      //change flag value to depict the on
                      // and off effect accordingly
                      setState(() {
                        isOff = !isOff;
                      });
                      //animate the cord back to the original position
                      cordAnimation = Tween<Offset>(
                              begin: endPosition,
                              end: Offset(widget.mediaWidth / 2,
                                  widget.mediaHeight / 2 + 100))
                          .animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval(0, 0.2, curve: Curves.linear),
                        ),
                      )..addListener(() {
                          setState(() {
                            endPosition = cordAnimation.value;
                          });
                        });

                      animationController.forward();
                    },
                    child: CustomPaint(
                      painter: CordPainter(startPosition, endPosition, isOff),
                      child: Container(),
                    ),
                  )
                : IgnorePointer(),
          ],
        ),
      ),
    ));
  }
}
