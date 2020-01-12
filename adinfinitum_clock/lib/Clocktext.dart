import 'dart:math';

import 'package:flutter/material.dart';

class ClockText extends StatelessWidget {
  static double angleAdd;

  static Container numText(
    int num,
  ) {
    angleAdd = num * 30 * 2 * 3.14 / 360;

    return Container(
      alignment: Alignment(
          cos(angleAdd + 270 * 3.14 / 180), sin(angleAdd + 270 * 3.14 / 180)),
      child: Text(
        num.toString(),
        style: TextStyle(fontSize: 14, color: Colors.red),
      ),
    );
  }

  static List<Widget> GetList() {
    List<Widget> x = [];
    for (int i = 1; i <= 12; i++) {
      x.add(numText(i));
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: GetList(),
    );
  }
}
