import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class SpringExample extends StatelessWidget {
  final SpringController springController =
      SpringController(initialAnim: Motion.pause);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Spring.shake(
          end: 240,
          springController: springController,
          delay: Duration(milliseconds: 100),
          animDuration: Duration(milliseconds: 1000),
          curve: Curves.easeInExpo,
          animStatus: (AnimStatus status) {
            print(status);
          },
          child: GestureDetector(
              onTap: () {
                //springController.play(motion: Motion.reverse);
                springController.play(motion: Motion.play);
              },
              child: Container(
                height: 140,
                width: 4,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }
}
