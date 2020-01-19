import 'package:analog_clock/Clocktext.dart';
import 'package:flutter/material.dart';

import 'AppColor.dart';
import 'drawn_hand.dart';

class Face extends StatefulWidget {
  Face({Key key, this.title, this.theme, this.seconds}) : super(key: key);
  MyTheme theme;
  int seconds;
  final String title;

  @override
  _FaceState createState() => _FaceState();
}

class _FaceState extends State<Face> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  double angle;
  int _counter = 0;
  int seconds = 0;
  double milliseconds;
  MyTheme theme;


  void incrementCounter() {
    setState(() {
      angle = animation.value;
      milliseconds = angle;

      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
        _counter++;
        if (_counter / 100 == 1) _counter = 0;
      }
      if (animationController.status == AnimationStatus.dismissed) {
        animationController.forward();
        _counter++;
        if (_counter / 100 == 1) _counter = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animation = Tween<double>(begin: 45, end: 135).animate(animation);
    animationController.addListener(() {
      incrementCounter();
    });
    animationController.forward();

//     animationController.addStatusListener((AnimationStatus)
//                                           {
//     if(animationController.status==)
//       animationController.reverse();}
//     );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: Lines(),
      child: ClockCard(seconds: widget.seconds, theme: widget.theme,),
    );
  }
}

class Lines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final angle = 2 * 3.14 / 60;

    Paint mpaint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.translate(size.width / 2 + 0.25, size.height / 2 + 15.5);

//    canvas.drawCircle(Offset(0, 0), radius - 5, mpaint);
    canvas.scale(1, -1);

//    canvas.drawPath(, mpaint);

//    TextPainter textPainter=TextPainter(text:TextSpan(text: (i/5).round().toString() ,),textDirection:TextDirection.ltr );
//    textPainter.layout(
//      minWidth: 0,
//      maxWidth: 30,
//    );
//    textPainter.paint(canvas,Offset(20,20));
    for (var i = 0; i < 60; i++) {
      canvas.drawLine(
          new Offset(0.0, radius - 20), new Offset(0.0, radius - 5), mpaint);

      canvas.rotate(angle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ClockCard extends StatelessWidget {
  ClockCard({
    Key key, this.theme,
    int seconds,
  })
      : _seconds = seconds,
        super(key: key);
  int _seconds;
  MyTheme theme;

  List<Color> defaultSet = [];

//  List<Color> sunColors=[];

  String loc;

  @override
  Widget build(BuildContext context) {
//    x.addListener(()=>
//
//        loc=x.location
//
//    );

    return Container(
      decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
//                      colors: [Color(0xFFffffff), Color(0xFFd7d6d6)]

//                    ),
//                    borderRadius: BorderRadius.circular(250 / 2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(offset: Offset(6, 6), color: theme.shade1, blurRadius: 12),
          BoxShadow(
              offset: Offset(-6, -6), color: theme.shade2, blurRadius: 12),
        ],
      ),
      margin: EdgeInsets.only(top: 30),
      height: 230,
      width: 230,
      child: Card(
        color: theme.main,
        child: Container(
          height: 230,
          width: 230,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.gradient1.withOpacity(0.5),
                  theme.gradient2.withOpacity(0.5),
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
                  color: Colors.cyan,
                  size: 0.5,
                  angleRadians: _seconds.truncateToDouble() * 0.10472 / 3600,
                  thickness: 7,
                ),
                DrawnHand(
                  color: Colors.orange,
                  size: 0.7,
                  angleRadians: _seconds.truncateToDouble() * 0.10472 / 60,
                  thickness: 7,
                ),
                DrawnHand(
                  color: Colors.green,
                  size: _seconds * 6 % 30 == 0 ? 0.8 : 1.0,
                  angleRadians: _seconds.truncateToDouble() * 0.10472,
                  thickness: 8,
                ),
              ],
            ),
          ),
        ),
        shape: CircleBorder(
            side: BorderSide(width: 1, color: theme.border.withOpacity(0.2))),
      ),
    );
  }
}
