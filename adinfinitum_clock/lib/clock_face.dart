import 'dart:math';

import 'package:analog_clock/Clocktext.dart';
import 'package:analog_clock/sun_position.dart';
import 'package:flutter/material.dart';

import 'AppColor.dart';
import 'drawn_hand.dart';

class Face extends StatefulWidget {
  Face({Key key, this.theme, this.animation}) : super(key: key);
  final MyTheme theme;
  final Animation animation;

  @override
  _FaceState createState() => _FaceState();
}

class _FaceState extends State<Face> with SingleTickerProviderStateMixin {
  DateTime _current = DateTime.now();

//  void incrementCounter() {
//    setState(() {
//      angle = animation.value;
//      milliseconds = angle;
//
//      if (animationController.status == AnimationStatus.completed) {
//        animationController.reverse();
//        _counter++;
//        if (_counter / 100 == 1) _counter = 0;
//      }
//      if (animationController.status == AnimationStatus.dismissed) {
//        animationController.forward();
//        _counter++;
//        if (_counter / 100 == 1) _counter = 0;
//      }
//    });
//  }

  @override
  void initState() {
    super.initState();

    widget.animation.addListener(() {
      setState(() {
        _current = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: Lines(),
      child: ClockCard(
        current: _current,
        theme: widget.theme,
      ),
    );
  }
}

class Lines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final angle = 2 * 3.14 / 60;
    Paint mpaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.translate(size.width / 2 + 0.25, size.height / 2 + 15.5);

    canvas.scale(1, -1);

    for (var i = 0; i < 60; i++) {
      double ticksize = i % 5 == 0 ? radius - 22 : radius - 15;

      canvas.drawLine(
          new Offset(0.0, ticksize), new Offset(0.0, radius - 4), mpaint);

      canvas.rotate(angle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ClockCard extends StatefulWidget {
  ClockCard({
    Key key,
    this.theme,
    this.current,
  }) : super(key: key);
  final DateTime current;
  final MyTheme theme;

  @override
  _ClockCardState createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  List<Color> defaultSet = [];
  double z;
  double x;
  double y;
  String loc;
  bool isDay = true;

  @override
  Widget build(BuildContext context) {
    DateTime dayttimeStart =
    DateTime(2020, widget.current.month, widget.current.day, 7, 15);
    DateTime dayttimeEnd =
    DateTime(2020, widget.current.month, widget.current.day, 17, 30);
    if (widget.current.isAfter(dayttimeStart) &&
        widget.current.isBefore(dayttimeEnd)) {
      isDay = true;
      z = -getSunPositionAsAngle(widget.current);

      x = -6 * cos(z);
      y = -6 * sin(z);
    } else {
      isDay = false;
      z = -getMoonPositionAsAngle(widget.current);

      x = -6 * cos(z);
      y = -6 * sin(z);
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(x, y),
            color: widget.theme.shade1,
            blurRadius: 12,
          ),
          BoxShadow(
              offset: Offset(-x, -y),
              color: widget.theme.shade2,
              blurRadius: 12),
        ],
      ),
      margin: EdgeInsets.only(top: 30),
      height: 230,
      width: 230,
      child: Stack(
        children: <Widget>[
          Card(
            color: widget.theme.main,
            child: Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment(-x / 6, -y / 6),
                    end: Alignment(x / 6, y / 6),
                    colors: [
                      widget.theme.gradient1.withOpacity(0.5),
                      widget.theme.gradient2.withOpacity(0.5),
                    ]),
              ),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                          alignment: Alignment.center,
                          height: 180,
                          width: 180,
                          child: ClockText()),
                    ),
                    DrawnHand(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        size: 0.5,
                        angleRadians: widget.current.hour * 2 * 3.14 / 12,
                        thickness: 7),
                    DrawnHand(
                      color: Colors.orange,
                      size: 0.7,
                      angleRadians: widget.current.minute * 2 * 3.14 / 60,
                      thickness: 5,
                    ),
                    DrawnHand(
                      color: Colors.green,
                      size: widget.current.second * 6 % 30 == 0 ? 0.7 : 1.0,
                      angleRadians: widget.current.second * 2 * 3.1415 / 60,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            shape: CircleBorder(
                side: BorderSide(
                    width: 1, color: widget.theme.border.withOpacity(0.2))),
          ),
          Container(
              alignment: Alignment(-x / 2.5, -y / 3.5),
//              height: 50,
//              width: 50,
              child: IconButton(
                iconSize: 45 + y,
                icon: Icon(isDay ? Icons.wb_sunny : Icons.brightness_2,
                    color: isDay ? Colors.amber[700] : Colors.grey),
                onPressed: null,
              )),
        ],
      ),
    );
  }
}
