// import 'package:drawing_animation/drawing_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
// class AnimatedPathPainter extends CustomPainter {
//   final Animation<double> _animation;

//   AnimatedPathPainter(this._animation) : super(repaint: _animation);

//   Path _createAnyPath(Size size) {
//     return Path()
//       ..moveTo(size.height / 4, size.height / 4)
//       ..lineTo(size.height, size.width / 2)
//       ..lineTo(size.height / 2, size.width)
//       ..quadraticBezierTo(size.height / 2, 100, size.width, size.height);
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final animationPercent = this._animation.value;

//     print("Painting + ${animationPercent} - ${size}");

//     //final path = createAnimatedPath(_createAnyPath(size), animationPercent);

//     final Paint paint = Paint();
//     paint.color = Colors.amberAccent;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10.0;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

// class AnimatedPathDemo extends StatefulWidget {
//   @override
//   _AnimatedPathDemoState createState() => _AnimatedPathDemoState();
// }

// class _AnimatedPathDemoState extends State<AnimatedPathDemo>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;

//   void _startAnimation() {
//     _controller.stop();
//     _controller.reset();
//     _controller.repeat(
//       period: Duration(seconds: 5),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(title: const Text('Animated Paint')),
//       body: SizedBox(
//         height: 300,
//         width: 300,
//         child: new CustomPaint(
//           painter: new AnimatedPathPainter(_controller),
//         ),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: _startAnimation,
//         child: new Icon(Icons.play_arrow),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }