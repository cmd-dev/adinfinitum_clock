import 'package:analog_clock/AppColor.dart';
import 'package:analog_clock/Clocktext.dart';
import 'package:analog_clock/clock_face.dart';
import 'package:analog_clock/container_hand.dart';
import 'package:analog_clock/drawn_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clock_helper/model.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  double angle;
  int _counter = 0;
  double milliseconds;
  String pendulumText = 'tik';
  int sec = 0;

  void incrementCounter() {
    setState(() {
      angle = animation.value;
      milliseconds = angle;
      sec = DateTime
          .now()
          .second;
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

    return Scaffold(
        backgroundColor: theme.main,
        body: Center(
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 250,
                    left: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 160,
                    child: Container(
                      height: 200,
                      width: 200,
                      color: theme.main,
                      child: Stack(children: [
                        Positioned(
                          left: 100,
                          child: Container(
//                            color: Colors.green,
                            child: Transform(
                              alignment: FractionalOffset.centerLeft,
                              transform: new Matrix4.rotationZ(
                                  (animation.value) * 3.14 / 180),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: 15,
                                    child: LinearProgressIndicator(
                                      backgroundColor: Color(0xffefeeee),
                                      value: _counter.truncateToDouble() / 100,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.amber,
                                      ),
                                    ),
                                  ),
                                  RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        animationController.status ==
                                            AnimationStatus.forward
                                            ? 'tok'
                                            : 'tik',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w200),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 76,
                            left: 20,
                            child: Container(
                                color: Colors.green,
                                child: Text('$angle'.substring(0, 4))))
                      ]),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery
                        .of(context)
                        .size
                        .width / 2 - 250 / 2 - 50,
                    child: Face(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
