import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() {
  runApp(MaterialApp(home: AnimationTest()));
}

class AnimationTest extends StatefulWidget {
  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controller.addListener(() {});

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (state == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: TestPainter(animation: animation),
                child: Center(),
              );
            }));
  }
}

List values = [];

class TestPainter extends CustomPainter {
  Animation animation;

  TestPainter({this.animation});

  Path mPath = Path();

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height / 2;

    canvas.translate(0, height);
//    canvas.scale(1, -1);
    double pi = animation.value;

    mPath.moveTo(0, 100);
    mPath.quadraticBezierTo(50, -pi * 80, 100, 0);
    mPath.quadraticBezierTo(150, pi * 80, 200, 0);
    mPath.quadraticBezierTo(250, -110 * pi, 300, 0);
    mPath.quadraticBezierTo(350, 80 * pi, 400, 0);
    mPath.quadraticBezierTo(450, -80 * pi, 500, 100);
    canvas.drawPath(mPath, Paint()..color=Colors.blue);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;
    print(pi.toString());
    values.add(pi);
    if (pi > 64) {
      for (int i = 0; i < values.length; i++) {
        canvas.drawRect(
            Rect.fromLTWH(values[i] * 29, Math.sin(values[i]) * 50, 10, 10),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => this != oldDelegate;

//   void render({double x, double y, Canvas canvas , Paint paint }) {
//     canvas.drawRect(Rect.fromLTWH(x, y, .5, .5), paint);

//   }
}
