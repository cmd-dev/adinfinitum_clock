import 'package:flutter/material.dart';

class Face extends StatefulWidget {
  Face({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FaceState createState() => _FaceState();
}

class _FaceState extends State<Face> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  double angle;
  int _counter = 0;
  double milliseconds;

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
  Widget build(BuildContext context) {}
}
