import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());
/*
class MyPainter extends CustomPainter {
  Animation animation;

  MyPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1, -1);
    canvas.drawLine(Offset(0, 0), Offset(100, 100), Paint());
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(15, 20),
            width: 60 + animation.value * 200,
            height: 200 - animation.value * 180),
        3.14 / 4,
        (90) * 3.14 / 180,
        false,
        Paint()..color = Colors.green);
  }

  @override
  bool shouldRepaint(MyPainter other) {
    return other.animation.value!=animation.value;
  }
}*/

class Water extends CustomPainter {
  Animation animation;

  Water(this.animation);

  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);
    final rect2 = Rect.fromLTWH(-100, -50, 200, 100);
    canvas.drawRect(rect2, Paint());
    canvas.scale(1, -1);
    final rect = Rect.fromLTRB(50, 100, 250, 200);
    final startAngle = 0.0;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;
    canvas.drawArc(
        rect2,
        3.1415,
        3.1415,
        false,
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 0), radius: animation.value * 100),
        startAngle,
        sweepAngle,
        !useCenter,
        paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Pai extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final angle = 2 * 3.14 / 60;

    Paint mpaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, mpaint);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);
    canvas.drawLine(Offset(90, 0), Offset(100, 0), mpaint);
    for (var i = 0; i < 60; i++) {
      canvas.rotate(angle);

      canvas.drawLine(
          new Offset(0.0, radius + 80), new Offset(0.0, radius + 90.0), mpaint);
      print(angle * i * 180 / 3.14);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) animationController.reverse();
        if (status == AnimationStatus.dismissed) animationController.forward();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: CustomPaint(
              foregroundPainter: Water(animationController),
              painter: Pai(),
              child: Text('PM'))),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
