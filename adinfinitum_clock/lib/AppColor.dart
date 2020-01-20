import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class MyTheme {
  Color main = Color(0xffefeeee);
  Color gradient1 = Color(0xffffffff);
  Color shade1 = Color(0xffcbcaca);
  Color shade2 = Color(0xffffffff);
  Color gradient2 = Color(0xffd7d6d6);
  Color border = Colors.grey;
  int index = 0;
  List<Widget> _conditionIcon = [
    Icon(Icons.location_on),
    Stack(
      children: <Widget>[
        Icon(Icons.cloud_queue, color: Colors.grey,),
        Positioned(
            top: 9,
            left: 3,
            child: Icon(Icons.flash_on, color: Colors.yellow, size: 20,)),
      ],
    ),

    Icon(Icons.flare, color: Colors.black,),

    Icon(Icons.wb_cloudy),

    Icon(Icons.ac_unit, color: Colors.blueAccent,),
    Icon(Icons.grain,), //fogg
    Transform.rotate(
        angle: 3.14 / 4,
        child: Icon(Icons.texture,)), //wind
    Icon(Icons.opacity, color: Colors.lightBlueAccent), //rain

  ];

  Widget getConditionIcon() {
    return _conditionIcon[index];
  }


  ClockModel x = new ClockModel();
  String condition;

  MyTheme(weathcondition) {
    condition = weathcondition;
    getWeather();
  }


  getWeather() {
    if (condition == enumToString(WeatherCondition.rainy)
    ) {
      index = 7;
      main = Color(0xff1976d2);
      gradient1 = Color(0xff1b7ee1);
      gradient2 = Color(0xff176abd);
      shade1 = Color(0xff1564b3);
      shade2 = Color(0xff1d88f2);
      border = Colors.blue;
    } else if (condition == enumToString(WeatherCondition.sunny)) {
      index = 2;
      main = Color(0xfffdd835);
      gradient1 = Color(0xffffe739);
      shade2 = Color(0xfffff83d);
      shade1 = Color(0xffd7b82d);
      gradient2 = Color(0xffe4c230);
      border = Colors.yellow;
    } else if (condition == enumToString(WeatherCondition.windy)) {
      index = 6;

      main = main.withBlue(200);
      gradient1 = gradient1.withBlue(200);
      shade1 = shade1.withBlue(200);
      shade2 = shade2.withBlue(200);
      gradient2 = gradient2.withBlue(200);
      border = Colors.blueAccent;
    } else if (condition == enumToString(WeatherCondition.cloudy)) {
      index = 3;
    } else if (condition == enumToString(WeatherCondition.snowy)) {
      index = 4;
    } else if (condition == enumToString(WeatherCondition.foggy)) {
      index = 5;
    }
    else if (condition == Brightness.dark.toString()) {
      index = 3;

      main = Color(0xff9e9e9e);
      gradient1 = Color(0xffa9a9a9);
      shade1 = Color(0xff868686);
      shade2 = Color(0xffb6b6b6);
      gradient2 = Color(0xff8e8e8e);
      border = Colors.grey;
    }
    else if (condition == enumToString(WeatherCondition.thunderstorm)) {
      index = 1;
    }
  }
}
