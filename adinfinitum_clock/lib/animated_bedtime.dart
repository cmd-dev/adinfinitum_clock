import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// class MyPainter extends CustomPainter {
//   Animation animation;

//   MyPainter(this.animation):super(repaint:animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.translate(0, size.height);
//     canvas.scale(1, -1);
//     canvas.drawLine(Offset(0, 0), Offset(100, 100), Paint());
//     canvas.drawArc(
//         Rect.fromCenter(
//             center: Offset(15, 20),
//             width: 60 + animation.value * 200,
//             height: 200 - animation.value * 180),
//         3.14 / 4,
//         (90) * 3.14 / 180,
//         false,
//         Paint()..color = Colors.green);
//   }

//   @override
//   bool shouldRepaint(MyPainter other) {
//     return false;
//   }
// }

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
  bool isLaunch = false;

  void _incrementCounter() {
    setState(() {
      isLaunch = !isLaunch;

//      if (animationController.status == AnimationStatus.completed)
//        animationController.reverse();
//      if (animationController.status == AnimationStatus.dismissed)
//        animationController.forward();
    });
  }

//  void initState() {
//    super.initState();
//    animationController = new AnimationController(
//      vsync: this,
//      duration: const Duration(seconds: 1),
//    )..addListener(() {
//        setState(() {
//          _incrementCounter();
//
//        });
//      });
//
//    animationController.forward();
//  }

  @override
  Widget build(BuildContext context) {
    double height = isLaunch ? 20 : 200;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: IconButton(
              onPressed: null,
              icon: isLaunch ? Icon(
                Icons.airline_seat_individual_suite,
                size: height,
              ) : Text('h'),
            ),
          ),
          height: height,
          width: height,
          alignment: isLaunch ? Alignment(-1, 1) : Alignment(1, 1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
