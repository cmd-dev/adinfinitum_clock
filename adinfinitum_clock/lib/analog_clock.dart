// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/Clocktext.dart';
import 'package:analog_clock/sun_position.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'AppColor.dart';
import 'clock_face.dart';
import 'container_hand.dart';
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
    with TickerProviderStateMixin {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
    getSunPositionAsAngle(_now);

    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animation = Tween<double>(begin: 45, end: 135).animate(animation);
    animationController
      ..addListener(() {
        _updateTime();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
//    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.

    });
  }

  @override
  Widget build(BuildContext context) {
    MyTheme theme = MyTheme(_condition);

    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final customTheme = Theme
        .of(context)
        .brightness == Brightness.light
        ? Theme.of(context).copyWith(
      // Hour hand.
      primaryColor: Colors.white,
      // Minute hand.
      highlightColor: Colors.pink,
      // Second hand.
      accentColor: Color(0xFF669DF6),
      backgroundColor: Color(0xFFD2E3FC),
    )
        : Theme.of(context).copyWith(
      primaryColor: Color(0xFFD2E3FC),
      highlightColor: Color(0xFF4285F4),
      accentColor: Color(0xFF8AB4F8),
      backgroundColor: Color(0xFF3C4043),
    );

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: customTheme.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_temperatureRange),
          Text(_condition),
          Text(_location),
        ],
      ),
    );

    return Semantics.fromProperties(
        properties: SemanticsProperties(
          label: 'Analog clock with time $time',
          value: time,
        ),
        child: Scaffold(
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
                                        value: _now.second.truncateToDouble() /
                                            100,
                                        valueColor: AlwaysStoppedAnimation<
                                            Color>(
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
                                  child: Text(_now.toIso8601String())))
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 250 / 2 - 50,
                      child: Face(theme: theme, animation: animation,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
