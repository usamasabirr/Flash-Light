import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  double angle = 0.0;
  double storeY = 0.0;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 20,
      stiffness: 0.1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
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
    print('x is ${_dragAlignment.x}');
    print('y is ${_dragAlignment.y}');
    print('tan is ${atan(_dragAlignment.y / _dragAlignment.x)}');

    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: GestureDetector(
        onPanDown: (details) {
          _controller.stop();
        },
        onPanUpdate: (details) {
          setState(() {
            // if (details.delta.dx != _dragAlignment.x) {
            print('change');
            angle = tan(_dragAlignment.y / _dragAlignment.x);
            print('angle is $angle');
            //}
            _dragAlignment += Alignment(
              details.delta.dx,
              details.delta.dy,
            );
          });
        },
        // onPanEnd: (details) {
        //   _runAnimation(details.velocity.pixelsPerSecond, size);
        // },
        child: Transform(
          transform: Matrix4.identity()..rotateZ(angle),
          child: Container(
            color: Colors.green,
            height: 80,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
