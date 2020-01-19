import 'package:flutter/material.dart';

//find current time subtract with 7:15 am
//total time for which the sun is visible in Mountain View CA is: 10hours 15 minutes (till 5:30 pm)

double getSunPositionAsAngle(DateTime current) {
  current = DateTime(2020, 1, 19, 17, 30);
  int day = current.day;
  int month = current.month;

  DateTime reference = DateTime(2020, month, day, 7, 15);
  DateTime endpointtime = reference.add(Duration(hours: 10, minutes: 15));
  Duration differenceofendwithref = endpointtime.difference(reference);
  Duration differenceofcurrentwithref = current.difference(reference);
  //check if current time is greater than 5:30 pm
  //if greater than go to night method
  if (current.difference(reference).inSeconds >
      differenceofendwithref.inSeconds) {
    return 0.1;
  } else {
    double fractionof180deg = differenceofcurrentwithref.inMinutes *
        3.14 /
        differenceofendwithref.inMinutes;
    return fractionof180deg;
  }
}
