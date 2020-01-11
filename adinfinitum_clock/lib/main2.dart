import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

void main() {runApp(MyApp());
SystemChrome.setEnabledSystemUIOverlays([]);


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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0xFFefeeee),
        body: Center(
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Center(
              child: Stack(


                children: <Widget>[

                  Positioned(
                    top:270 ,
                    left:MediaQuery.of(context).size.width/2-150 ,
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Color(0xffefeeee),
                      child: Stack(children: [
                        Positioned(
                          left: 100,
                          child: Container(
//                            color: Colors.green,
                            child: Transform(
                              alignment: FractionalOffset.centerLeft,
                              transform: new Matrix4.rotationZ(
                                  (animation.value) * 3.14 / 180),
                              child: Container(
                                width: 80,
                                height: 15,
                                child: LinearProgressIndicator(

                                  backgroundColor: Colors.grey,
                                  value: _counter.truncateToDouble() / 100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 76,
                            left: 20,
                            child: Container(
                                color: Colors.green, child: Text('$angle')))
                      ]),
                    ),
                  ),


                  Positioned(
                    top: 0,
                    left:MediaQuery.of(context).size.width/2-250/2-50 ,

                    child: Container(
                      decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                      begin: Alignment.topLeft,
//                      end: Alignment.bottomRight,
//                      colors: [Color(0xFFffffff), Color(0xFFd7d6d6)]

//                    ),
//                    borderRadius: BorderRadius.circular(250 / 2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(

                              offset: Offset(9, 9),
                              color: Color(0xffcbcaca),
                              blurRadius: 20),
                          BoxShadow(
                              offset: Offset(-9, -9),
                              color: Color(0xffffffff),
                              blurRadius: 20)
                        ],
                      ),
                      margin: EdgeInsets.only(top: 30),
                      height: 250,
                      width: 250,
                      child: Card(
                        color: Color(0xffefeeee),
//            elevation: 1,
                        child: Container(
                          height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xffffffff).withOpacity(0.5), Color(0xffd7d6d6).withOpacity(0.5)]),),

                            child: Center(child: Text('pm',style: TextStyle(fontSize: 40),))),
                        shape: CircleBorder(
                            side: BorderSide(
                              width: 1,
                                color: Color(0xFFFFFF).withOpacity(0.2))),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
