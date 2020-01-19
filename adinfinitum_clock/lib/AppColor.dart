import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class MyTheme {
  Color main = Color(0xff9e9e9e);
  Color gradient1 = Color(0xffa9a9a9);
  Color shade1 = Color(0xff868686);
  Color shade2 = Color(0xffb6b6b6);
  Color gradient2 = Color(0xff8e8e8e);
  Color border = Colors.grey;
  ClockModel x = new ClockModel();
  String condition;

  MyTheme(weathcondition) {
    condition = weathcondition;
    getWeather();
  }

  getWeather() {
    if (condition == enumToString(WeatherCondition.rainy) ||
        condition == enumToString((WeatherCondition.thunderstorm))) {
      main = Color(0xff1976d2);
      gradient1 = Color(0xff1b7ee1);
      gradient2 = Color(0xff176abd);
      shade1 = Color(0xff1564b3);
      shade2 = Color(0xff1d88f2);
      border = Colors.blue;
    } else if (condition == enumToString(WeatherCondition.snowy) ||
        condition == enumToString(WeatherCondition.foggy)) {
      main = Color(0xffefeeee);
      gradient1 = Color(0xffffffff);
      shade1 = Color(0xffcbcaca);
      shade2 = Color(0xffffffff);
      gradient2 = Color(0xffd7d6d6);
      border = Colors.white;
    } else if (condition == enumToString(WeatherCondition.sunny)) {
      main = Color(0xfffdd835);
      gradient1 = Color(0xffffe739);
      shade2 = Color(0xfffff83d);
      shade1 = Color(0xffd7b82d);
      gradient2 = Color(0xffe4c230);
      border = Colors.yellow;
    } else if (condition == enumToString(WeatherCondition.windy)) {
      main = main.withBlue(200);
      gradient1 = gradient1.withBlue(200);
      shade1 = shade1.withBlue(200);
      shade2 = shade2.withBlue(200);
      gradient2 = gradient2.withBlue(200);
      border = Colors.blueAccent;
    }
  }
}
