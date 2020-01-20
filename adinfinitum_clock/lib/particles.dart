import 'package:analog_clock/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';
import 'dart:math';

class PhysicsAnimation extends StatefulWidget {
  PhysicsAnimation(this.icon);

  Widget icon;

  _PhysicsAnimation createState() => _PhysicsAnimation();
}

class _PhysicsAnimation extends State<PhysicsAnimation>
    with TickerProviderStateMixin {
  AnimationController controller;
  GravitySimulation simulation;
  List<Widget> particles = [];
  bool isLoad = true;

  Random random = new Random();

  @override
  void initState() {
    super.initState();

    simulation = GravitySimulation(
      100, // acceleration
      40.0, // starting point
      900.0, // end point
      5, // starting velocity
    );

    controller = AnimationController(vsync: this, upperBound: 800)
      ..addListener(() {
        setState(() {});
      });

    controller.animateWith(simulation);
//    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.value);

    return Stack(children: [
      Positioned(
          left: 50,
          top: controller.value,
          height: 10,
          width: 10,
          child: widget.icon),
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
