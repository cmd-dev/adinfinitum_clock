import 'dart:math';
import 'package:flutter/animation.dart';

class AccelerateCurve extends Curve {
  @override
  double transform(double t) => 0.5 * 9.8 * pow(t, 2) % 1;
}
